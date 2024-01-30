//
//  WeatherIconError.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import Foundation

enum WeatherIconError: Error {
    case invalidURL
    case imageLoadFailed

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL for weather icon."
        case .imageLoadFailed:
            return "Failed to load weather icon image."
        }
    }
}

// Add more cases as needed
