//
//  Label.swift
//  5Day Weather
//
//  Created by Adel on 1/27/24.
//

import UIKit

extension UILabel {
    
    func applyTextOutlineShadow(withColor color: UIColor = .black, outlineWidth: CGFloat = 1) {
        // Apply a shadow to create an outline effect around the text
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 1
        layer.shadowRadius = outlineWidth
        layer.masksToBounds = false
    }
}
