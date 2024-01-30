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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    var viewModel: WeatherDetailViewModel?
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var horizontalStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getWeatherInfoForSelectedDay()
        setupView()
        addArrangedDetailViews()
        [temperatureLabel, feelsLikeLabel].forEach{$0?.applyTextOutlineShadow()} 
        scrollView.roundCorners(corners: [.topLeft, .topRight], radius: .grid(3 ))
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.roundCorners(corners: [.topLeft, .topRight], radius: .grid(3 ))
    }
    
    func setupView() {
        let temperature = viewModel?.selectedWeatherInfo?.mainInfo.getFeelsLike()
        temperatureLabel.text = temperature
        
        let bgName = viewModel?.selectedWeatherInfo?.getDescription()
            .appending(ImageURLProvider.detail_background_ext) ?? ""
        bgImageView.image = UIImage(named: bgName)
    }

    func addArrangedDetailViews()  {
        if let viewModel,  !viewModel.currentForCastDetail.isEmpty {
            viewModel.currentForCastDetail.forEach { item in
                if let detailView = WeatherBlockView.loadFromNib() {
                                        detailView.updateViewWith(weatherItem: item)
                    horizontalStackView.addArrangedSubview(detailView)
                }
            }
        }
    }
}

enum ImageLoadingError: Error {
    case failedToLoadImage
}
