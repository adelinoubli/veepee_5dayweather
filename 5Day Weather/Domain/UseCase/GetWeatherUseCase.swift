//
//  GetWeatherUseCase.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import UIKit
import Combine

protocol GetWeatherUseCase {
    func execute() -> Future<WeatherResponse, Error>

}
