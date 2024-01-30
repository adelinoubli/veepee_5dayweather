//
//  WeatherViewModel.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//
import Foundation
import Combine
import UIKit

class WeatherDetailViewModel {
    
    // MARK: - Published Properties
    /// The latest weather response received from the API.
    @Published var weatherResponse: WeatherResponse?
    
    /// The selected weather information for detailed view.
    var selectedWeatherInfo: WeatherInfo?
    
    /// An array containing weather information for the current forecast detail.
    var currentForCastDetail: [WeatherInfo] = []
    
    /// Any error that occurred during the data fetching process.
    @Published var error: Error?
    
    /// The downloaded weather icon image.
    @Published var icon: UIImage?
    
    /// The timestamp for the selected weather information.
    var timestamp: Int? {
        return selectedWeatherInfo?.timestamp ?? 0
    }
    
    // MARK: - Other Properties
        private var cancellables: Set<AnyCancellable> = []

    /// The use case responsible for fetching weather data.
    var weatherUseCase: GetWeatherUseCase?
    
    // MARK: - Initialization
    
    /// Initializes the WeatherDetailViewModel.
    /// - Parameter getWeatherUseCase: The object for fetching weather data.
    init(_ getWeatherUseCase: GetWeatherUseCase? = nil) {
        self.weatherUseCase = getWeatherUseCase
    }
    
    /// Retrieves weather information for the selected day.
    func getWeatherInfoForSelectedDay() {
        // Convert timestamp to Date
        if let timestamp, let weatherList = weatherResponse?.weatherList {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
            // Get components for the selected day
            let calendar = Calendar.current
            let selectedDay = calendar.component(.day, from: date)
            
            // Filter the weather list for the selected day using higher-order function
            let filteredWeatherList = weatherList.filter {
                let weatherDate = Date(timeIntervalSince1970: TimeInterval($0.timestamp))
                let weatherDay = calendar.component(.day, from: weatherDate)
                return weatherDay == selectedDay
            }
            
            currentForCastDetail = filteredWeatherList
        }
    }
}
