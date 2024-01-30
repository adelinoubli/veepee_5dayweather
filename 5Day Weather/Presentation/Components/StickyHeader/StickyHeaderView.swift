//
//  StickyHeaderView.swift
//  5Day Weather
//
//  Created by Adel on 1/25/24.
//


import Foundation
import UIKit

class StickyHeaderView: UIView {
    var imageView:UIImageView!
    var colorView:UIView!
    var bgColor = UIColor(red: 255/255, green: 64/255, blue: 122/255, alpha: 0.9)
    var titleLabel = UILabel()
    var weatherLabel = UILabel()

    var articleIcon:UIImageView!
    
    init(frame:CGRect, title: String) {
         self.titleLabel.text = title.uppercased()
         super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.backgroundColor = UIColor.white
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.5
        self.addSubview(imageView)
        
        colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(colorView)
        
        let constraints:[NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        imageView.image = UIImage(named: Images.headerBackground)
        imageView.contentMode = .scaleAspectFill
        colorView.backgroundColor = bgColor
        colorView.alpha = 0.4
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        let titlesConstraints:[NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(titlesConstraints)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor  =  .init(white: 1, alpha: 0.7)
        titleLabel.textAlignment = .left
    }
    
    func decrementColorAlpha(offset: CGFloat) {
        if self.colorView.alpha <= 1 {
            let alphaOffset = (offset/300)/85
            self.colorView.alpha += alphaOffset
        }
    }

    func incrementColorAlpha(offset: CGFloat) {
        if self.colorView.alpha >= 0.4 {
            let alphaOffset = (offset/100)/85
            self.colorView.alpha -= alphaOffset
        }
    }
}
