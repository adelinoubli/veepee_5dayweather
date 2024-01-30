//
//  DataSourceService.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Combine
import UIKit

protocol WeatherRepository {
    func fetchWeather<T: Decodable>(responseType: T.Type) -> Future<T,Error>
}

