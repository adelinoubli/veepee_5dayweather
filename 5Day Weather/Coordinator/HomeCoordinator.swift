//
//  c.swift
//  5-Day Weather
//
//  Created by Adel on 1/25/24.
//

import UIKit

class HomeCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?
    

    init(navigationController :UINavigationController?) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    let apiManager = DependencyConfigurator.getUseCase()

    override func start() {
        let home = WeatherViewController.instantiateViewController()
        let viewModel = WeatherViewModel(apiManager)
        home.coordinator = self
        home.viewModel = viewModel
        navigationController?.pushViewController(home, animated: true)
    }

    func showDetail(_ response: WeatherResponse, selectedWeatherInfo: WeatherInfo, in navigationController: UINavigationController?) {
        let detailsViewController = WeatherDetailViewController.instantiateViewController()
        let viewModel = WeatherDetailViewModel(apiManager)
        viewModel.weatherResponse = response
        viewModel.selectedWeatherInfo = selectedWeatherInfo
            detailsViewController.viewModel = viewModel
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
