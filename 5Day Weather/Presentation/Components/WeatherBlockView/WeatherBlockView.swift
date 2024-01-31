//
//  WeatherBlockView.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import UIKit
import SDWebImage

class WeatherBlockView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    static func loadFromNib() -> WeatherBlockView? {
        let nibName = "WeatherBlockView"
        let bundle = Bundle(for: WeatherBlockView.self)
        
        if let nib = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? WeatherBlockView {
            return nib
        } else {
            return nil
        }
    }
    
    override func layoutSubviews() {
    super.layoutSubviews()
        temperatureLabel.applyTextOutlineShadow(withColor: .white)
    }
    
    func withLargeTemperatureSize() -> Self {
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 40)
        return self
    }
    
    func updateViewWith(weatherItem: WeatherInfo, shouldUseRelativeDate: Bool = false) {
        
        let timestamp = weatherItem.timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let time = shouldUseRelativeDate ? date.relativeTime() :
        timestamp.toDateFormattedString(format: .hourAMPM)
        self.timeLabel.text = time

        self.temperatureLabel.text = weatherItem.mainInfo?.getFeelsLike()

        guard let icon = weatherItem.weather.first?.icon else { return }
        let imageURL = ImageURLProvider.imageURL(forIconName: icon)
        self.iconImageView.sd_setImage(with: imageURL,
                                       placeholderImage: UIImage(named: ImageURLProvider.networkError))
    }
}
