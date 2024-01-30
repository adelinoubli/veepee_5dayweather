//
//  RemoteDataSource.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation
import Combine
import Moya
import SDWebImage

class RemoteRepositoryImp: WeatherRepository {
    
    var cancelable = Set<AnyCancellable>()
    
    private var target: RequestHandler
    
    init(target: RequestHandler) {
        self.target = target
    }
    
    func fetchWeather<T: Decodable>(responseType: T.Type) -> Future<T, Error> {
        Future<T, Error> {promise in
            let apis: RequestHandler = .forecast
            let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
            
            let provider = MoyaProvider<RequestHandler>(plugins: [plugin])
            provider.requestPublisher(apis)
                .sink(receiveCompletion: { _ in},
                receiveValue: { response in
                    do {
                        let result = try JSONDecoder().decode(T.self, from: response.data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                })
                .store(in: &self.cancelable)
        }
    }
}


