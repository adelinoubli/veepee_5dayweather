//
//  DependencyConfigurator.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Reachability

class DependencyConfigurator {
    
    static func getUseCase() -> GetWeatherUseCase {
        let dataSourceProvider: WeatherDataSourceProvider = isInternetAvailable()
            ? NetworkWeatherDataSourceProvider()
            : LocalWeatherDataSourceProvider(fileName: Constant.jsonFileName)

        let dataSource: WeatherRepository = dataSourceProvider.getWeatherDataSource()
        return GetWeatherUseCaseImpl(repository: dataSource)
    }
    
    static func isInternetAvailable() -> Bool {
        let reachability = try? Reachability()
        return reachability?.connection != .unavailable
    }
}

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
