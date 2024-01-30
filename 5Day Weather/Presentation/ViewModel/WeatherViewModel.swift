//
//  WeatherViewModel.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import Foundation
import Combine

class WeatherViewModel {
    
    // MARK: - Published Properties
    
    /// The  weather response received from the API.
    @Published var weatherResponse: WeatherResponse?
    /// a Published value to observe internet connection status change.
    @Published var isInternetReachable: Bool = true

    /// Any error that occurred during the weather data fetching process.
    @Published var error: Error?
    
    
    // MARK: - Other Properties
    /// An array containing the overview of the weather forecast.
    var overViewResponse: [WeatherInfo]?
    
    /// The object responsible for fetching weather data.
    var getWeatherUseCase: GetWeatherUseCase?
    
    private var cancellables: Set<AnyCancellable> = []

    var promtDataFetchingFromLocal = false
    // MARK: - Initialization
    
    /// Initializes the WeatherViewModel.
    /// - Parameter getWeatherUseCase: The use case for fetching weather data.
    init(_ getWeatherUseCase: GetWeatherUseCase? = nil) {
        observeReachability()
        self.getWeatherUseCase = getWeatherUseCase
    }
    
    // MARK: - Public Methods
    
    /// Fetches the latest weather data from the API.
     func fetchWeather() {
    getWeatherUseCase?.execute()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.promtDataFetchingFromLocal = true
                    self?.handleWeatherFetchError(error)
                }
            },
            receiveValue: { [weak self] response in
                self?.weatherResponse = response
                //We do not to want change the update date when the data is loaded from local nor replace the response we  already have.
                if !(self?.promtDataFetchingFromLocal ?? false) || !(self?.isInternetReachable ?? false) {
                    self?.saveWeatherResponse()
                    self?.saveUpdateDate()
                }
                self?.getForeCastOverView()
                self?.error = nil
            }
        )
        .store(in: &cancellables)
}
    
    private func handleWeatherFetchError(_ error: Error) {
        self.error = error
            switchToLocalDataSource()
    }

    private func switchToLocalDataSource() {
        // Switch to local data source
        let localDataSource = LocalRepositoryImp(fileName: Constant.jsonFileName)
        getWeatherUseCase = GetWeatherUseCaseImpl(repository: localDataSource)
        
        fetchFromLocalIfDataExist()
    }

    private func fetchFromLocalIfDataExist() {
        fetchWeather()
    }
    
    // MARK: - Private Methods
    
    /// Saves the latest weather response to local storage.
    private func saveWeatherResponse() {
            let persistenceManager = LocalPersistenceService()
            persistenceManager.saveObject(self.weatherResponse, toFile: Constant.jsonFileName)
    }
    
    /// Extracts an overview of the weather forecast from the received response. (  5 days  )
    private func getForeCastOverView() {
        overViewResponse = weatherResponse?.weatherList
            .sorted { $0.timestamp < $1.timestamp }
            .reduce(into: [String: WeatherInfo]()) { dict, weatherInfo in
                let day = weatherInfo.timestamp.toDateFormattedString(format: .day)
                if dict[day] == nil {
                    dict[day] = weatherInfo
                }
            }
            .values
            .sorted { $0.timestamp < $1.timestamp } // Ensure the final result is sorted by timestamp
    }
    
    func saveUpdateDate() {
        if !promtDataFetchingFromLocal {
            let dateStorage = DefaultDataStorage()
            dateStorage.saveDate(Date(), forKey: UserStorageKeys.last_update)
        }
    }
    private func observeReachability() {
            ReachabilityManager.shared.$isReachable
                .assign(to: \.isInternetReachable, on: self)
                .store(in: &cancellables)
        }
}
