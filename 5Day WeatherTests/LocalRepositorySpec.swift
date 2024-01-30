//
//  LocalRepositorySpec.swift
//  5Day WeatherTests
//
//  Created by Adel on 1/28/24.
//

import Foundation
import  Combine
import Quick
import Nimble

@testable import _Day_Weather

class LocalRepositorySpec: QuickSpec {
     func spec() {
        LocalRepositorySpec.describe("LocalRepositoryImp") {
            LocalRepositorySpec.context("when fetching weather from a local file") {
                LocalRepositorySpec.it("should decode the WeatherResponse model") {
                    let jsonFileName = Constant.jsonFileName
                    let localRepository = LocalRepositoryImp(fileName: jsonFileName)

                    var cancellables: Set<AnyCancellable> = []
                    
                    // Act & Assert
                    waitUntil { done in
                        localRepository.fetchWeather(responseType: WeatherResponse.self)
                            .sink(receiveCompletion: { _ in done() },
                                  receiveValue: { weatherResponse in
                                      expect(weatherResponse).to(beAKindOf(WeatherResponse.self))
                                      // Add more specific assertions if needed
                                  })
                            .store(in: &cancellables)
                    }
                }
            }
        }
    }
}
