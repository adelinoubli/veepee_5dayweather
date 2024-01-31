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
