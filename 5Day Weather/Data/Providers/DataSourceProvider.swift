//
//  DataSourceProvider.swift
//  5Day Weather
//
//  Created by Adel on 1/31/24.
//

import Foundation

protocol WeatherDataSourceProvider {
    func getWeatherDataSource() -> WeatherRepository
}

class NetworkWeatherDataSourceProvider: WeatherDataSourceProvider {
    func getWeatherDataSource() -> WeatherRepository {
        let apis: RequestHandler = .forecast
        return RemoteRepositoryImp(target: apis)
    }
}

class LocalWeatherDataSourceProvider: WeatherDataSourceProvider {
    private let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    func getWeatherDataSource() -> WeatherRepository {
        return LocalRepositoryImp(fileName: fileName)
    }
}

