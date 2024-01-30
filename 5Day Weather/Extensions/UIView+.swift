//
//  UIView+.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//
import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat? = nil) {
        switch corners {
        case .bottomLeft:
            layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .topLeft:
            layer.maskedCorners = [.layerMaxXMinYCorner]
        case .topRight:
            layer.maskedCorners = [.layerMaxXMinYCorner]
        default:
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner,
                                   .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }

        if let cornerRadius = radius {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = frame.height / 2
        }
    }

    // MARK: - Shadow

    static var defaultShadowColor: UIColor {
        return UIColor.black.withAlphaComponent(0.33)
    }

    /// Apply shadow to the view
    /// - parameter radius: The blur radius (in points) used to render the layer’s shadow. Default value: 2
    /// - parameter opacity: The opacity of the layer’s shadow. Default value: 0.15
    /// - parameter offset: The offset (in points) of the layer’s shadow. Default value: CGSize(width: 0, height: 1)
    /// - parameter color: The color of the layer’s shadow. Default value: opaque black
    func applyShadow(radius: CGFloat = 2,
                     opacity: Float = 0.15,
                     offset: CGSize = CGSize(width: 0, height: 1),
                     color: UIColor = defaultShadowColor) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

    func applyPathShadow(radius: CGFloat = 2, opacity: CGFloat = 0.2) {
        let rect = CGRect(x: 0, y: 0, width: frame.width, height: radius)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = radius
        layer.shadowPath = CGPath(rect: rect, transform: nil)
        layer.shadowOpacity = Float(opacity)
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}
