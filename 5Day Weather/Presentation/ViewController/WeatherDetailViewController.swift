//
//  WeatherDetailViewController.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import UIKit
import Combine
import SDWebImage

class WeatherDetailViewController: UIViewController, StoryboardInstantiable {

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    // MARK: - Properties
    
    var viewModel: WeatherDetailViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addArrangedDetailViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyStyling()
    }
    
    // MARK: - Setup
    
    func setupView() {
        viewModel?.getWeatherInfoForSelectedDay()
        
        // Display temperature
        let temperature = viewModel?.selectedWeatherInfo?.mainInfo?.getFeelsLike()
        temperatureLabel.text = temperature
        
        // Display background image based on weather description
        if let description = viewModel?.selectedWeatherInfo?.getDescription() {
            let bgName = description.appending(ImageURLProvider.detail_background_ext)
            bgImageView.image = UIImage(named: bgName)
        }
    }

    // MARK: - Detail Views

    func addArrangedDetailViews()  {
        guard let viewModel = viewModel, !viewModel.currentForCastDetail.isEmpty else {
            return
        }
        
        // Add WeatherBlockView for each detail item
        for item in viewModel.currentForCastDetail {
            if let detailView = WeatherBlockView.loadFromNib() {
                detailView.updateViewWith(weatherItem: item)
                horizontalStackView.addArrangedSubview(detailView)
            }
        }
    }
    
    // MARK: - Styling
    
    func applyStyling() {
        scrollView.roundCorners(corners: [.topLeft, .topRight], radius: .grid(3))
        [temperatureLabel, feelsLikeLabel].forEach { $0?.applyTextOutlineShadow() }
    }
}
