//
//  OnlineWeatherFetchingSpec.swift
//  5Day WeatherTests
//
//  Created by Adel on 1/28/24.
//


import Quick
import Nimble
import Combine

@testable import _Day_Weather

    
class OnlineWeatherFetchingSpec: QuickSpec {
    

     func spec() {
         
         OnlineWeatherFetchingSpec.describe("Online Weather Fetching") {
            var cancellables: Set<AnyCancellable> = []
            var repository: WeatherRepository!

             OnlineWeatherFetchingSpec.beforeEach {
                repository = RemoteRepositoryImp(target: .forecast)
            }

             OnlineWeatherFetchingSpec.it("should successfully fetch online weather response") {
                waitUntil { done in
                    repository.fetchWeather(responseType: WeatherResponse.self)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                done()
                            case .failure(let error):
                                fail("Should not fail: \(error)")
                            }
                        }, receiveValue: { response in
                            expect(response).toNot(beNil())
                            // Add more expectations on the response as needed
                        })
                        .store(in: &cancellables)
                }
            }

            // Add more online weather fetching tests as needed
        }
    }
}
