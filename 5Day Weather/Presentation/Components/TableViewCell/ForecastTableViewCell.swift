//
//  ForecastTableViewCell.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()
                backgroundImage.roundCorners(corners: [.allCorners], radius: 20)
                viewHolder.applyShadow(radius: 5,
                                       opacity: 0.2,
                                       offset: CGSize(width: 3, height: 3),
                                       color: UIColor.black)
    }
    
    func updateView(with weatherInfo: WeatherInfo) {
        let foreCastDesc = weatherInfo.getDescription()
        backgroundImage.image = UIImage(named: foreCastDesc)
        temperatureLabel.text  = weatherInfo.mainInfo?.getTemperature()
        dateLabel.text = weatherInfo.timestamp.getRelativeDay()
        descriptionLabel.text = weatherInfo.weather.first?.description
    }
}
