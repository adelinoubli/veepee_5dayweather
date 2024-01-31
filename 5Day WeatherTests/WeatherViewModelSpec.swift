//
//  WeatherViewModelSpec.swift
//  5Day WeatherTests
//
//  Created by Adel on 1/31/24.
//
import Quick
import Nimble
@testable import _Day_Weather

class WeatherViewModelSpec: QuickSpec {
     func spec() {
         WeatherViewModelSpec.describe("WeatherViewModel") {
            var viewModel: WeatherViewModel!

             WeatherViewModelSpec.beforeEach {
                viewModel = WeatherViewModel()
            }

             WeatherViewModelSpec.context("when fetching weather") {
                 WeatherViewModelSpec.it("should have sorted timestamps in overviewResponse") {
                    // Mock WeatherResponse with unsorted timestamps
                    let unsortedWeatherList = [
                        WeatherInfo(timestamp: 1706464800, mainInfo: nil, weather: [], clouds: nil, wind: nil, visibility: nil, precipitationProbability: nil, sys: nil, dateTimeText: nil),
                        WeatherInfo(timestamp: 1706464800, mainInfo: nil, weather: [], clouds: nil, wind: nil, visibility: nil, precipitationProbability: nil, sys: nil, dateTimeText: nil),
                        WeatherInfo(timestamp: 1706713200, mainInfo: nil, weather: [], clouds: nil, wind: nil, visibility: nil, precipitationProbability: nil, sys: nil, dateTimeText: nil)
                    ]
                     
                    let mockWeatherResponse = WeatherResponse(responseCode: "", message: 0, count: 0, weatherList: unsortedWeatherList, city: nil)
                     
               
                    viewModel.weatherResponse = mockWeatherResponse

                    viewModel.getForeCastOverView()

                    // Assert that overviewResponse has sorted timestamps
                    expect(viewModel.overViewResponse).toNot(beNil())
                    expect(viewModel.overViewResponse?.count) == unsortedWeatherList.count

                    // Check if timestamps are sorted
                    let sortedTimestamps = viewModel.overViewResponse?.map { $0.timestamp }
                    let isSorted = sortedTimestamps == sortedTimestamps?.sorted()
                    expect(isSorted) == true
                }
            }
        }
    }
}

