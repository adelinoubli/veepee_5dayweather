//
//  Constant.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation

struct Constant {
    static let jsonFileName = "latestWeatherReponse.json"
    static let APIKey = "ee014aa5f77a16acf59b12a54457664c"
    static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    static let cityName = "Paris"
    static let units = "metric"

}

struct UserStorageKeys {
    static let last_update = "last_update_date"
}

struct Images {
    static let headerBackground = "stickyBackground"
}
struct ImageURLProvider {
    static let baseURL = "https://openweathermap.org/img/wn/"
    static let detail_background_ext = "_dt"
    static let networkError = "networkErrorIcon"
    static func imageURL(forIconName iconName: String) -> URL? {
        return URL(string: baseURL + "\(iconName)@4x.png")
    }
}

//Messages  {
enum WeatherMessages {
    static let noLocalData = "No local data found, Please try again later"
    static let lastUpdateTimeFormat = "Last update time: %@"
}

enum Dialog  {
    static let title = "Network error"
    static let message = "No local data found, Please try again later"
}
