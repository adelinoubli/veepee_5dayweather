//
//  WeatherResponse.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation
import Foundation

struct WeatherResponse: Codable {
    let responseCode: String
    let message: Int
    let count: Int
    let weatherList: [WeatherInfo]
    let city: City

    enum CodingKeys: String, CodingKey {
        case responseCode = "cod"
        case message
        case count = "cnt"
        case weatherList = "list"
        case city
    }
    
}

struct WeatherInfo: Codable {
    let timestamp: Int
    let mainInfo: Main
    let weather: [WeatherDescription]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let precipitationProbability: Double
    let sys: Sys
    let dateTimeText: String

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case mainInfo = "main"
        case weather
        case clouds
        case wind
        case visibility
        case precipitationProbability = "pop"
        case sys
        case dateTimeText = "dt_txt"
    }
    
    func getDescription() -> String {
        return weather.first?.main ?? ""
    }

}

struct Main: Codable {
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Int
    let seaLevel: Int
    let groundLevel: Int
    let humidity: Int
    let temperatureKf: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        case temperatureKf = "temp_kf"
    }
    
    func getTemperature() ->  String {
        return "\(String(Int(minTemperature)))°↓"
    }
    
    func getFeelsLike() ->  String {
        return "\(String(Int(feelsLike)))°"
    }
}

struct WeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main, description, icon
    }
}

struct Clouds: Codable {
    let coveragePercentage: Int

    enum CodingKeys: String, CodingKey {
        case coveragePercentage = "all"
    }
}

struct Wind: Codable {
    let speed: Double
    let degrees: Int
    let gust: Double

    enum CodingKeys: String, CodingKey {
        case speed, degrees = "deg", gust
    }
}

struct Sys: Codable {
    let pod: String

    enum CodingKeys: String, CodingKey {
        case pod
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coordinates: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int

    enum CodingKeys: String, CodingKey {
        case id, name, coordinates = "coord", country, population, timezone, sunrise, sunset
    }
}

struct Coord: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
