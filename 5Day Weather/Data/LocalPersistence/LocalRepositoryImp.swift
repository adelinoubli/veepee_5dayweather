//
//  LocalDataSource.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation
import Combine

class LocalRepositoryImp: WeatherRepository {
    
    private var jsonFileName: String
    
    init(fileName: String) {
        self.jsonFileName = fileName
    }
    
    func fetchWeather<T: Decodable>(responseType: T.Type) -> Future<T, Error> {
        return Future { promise in
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }

            let fileURL = documentsDirectory.appendingPathComponent(self.jsonFileName)
            
            if let data = try? Data(contentsOf: fileURL) {
                do {
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(T.self, from: data)
                    promise(.success(weatherResponse))
                } catch {
                    promise(.failure(error))
                }
            } else {
                let error = NSError(domain: "Local fetching error", code: 0, userInfo: nil)
                promise(.failure(error))
            }
        }
    }
}
