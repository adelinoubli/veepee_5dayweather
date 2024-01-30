//
//  APIManager.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import UIKit
import Combine

class GetWeatherUseCaseImpl: GetWeatherUseCase {
        
    private let weatherRepository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.weatherRepository = repository
    }
    
    func execute() -> Future<WeatherResponse, Error> {
        return weatherRepository.fetchWeather(responseType: WeatherResponse.self)
    }
}
