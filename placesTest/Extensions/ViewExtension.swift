//
//  ViewExtension.swift
//  placesTest
//
//  Created by André Alves on 23/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

extension UIView {
    public func roundCorners(_ corners: UIRectCorner = [.allCorners], radius: CGFloat = 3) {
        self.layer.masksToBounds = false

        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let roundLayer = CAShapeLayer()
        roundLayer.frame = self.bounds
        roundLayer.path = path.cgPath
        self.layer.mask = roundLayer
    }

    public func createShadowLayer(cornerRadius corner: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float) -> CAShapeLayer{

        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: corner).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor

        shadowLayer.shadowColor = shadowColor.cgColor

        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.masksToBounds = false

        return shadowLayer
    }

    public func addShadow(cornerRadius corner: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat) {

        let shadowLayer = createShadowLayer(cornerRadius: corner, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: .black, shadowOpacity: 1)
        self.layer.insertSublayer(shadowLayer, at: 0)
        self.layer.masksToBounds = false
    }

    public func addShadow() {
        addShadow(cornerRadius: 3)
    }

    public func addShadow(_ fromLayer: CAShapeLayer?, cornerRadius corner: CGFloat) -> CAShapeLayer {
        let shadowLayer = createShadowLayer(cornerRadius: corner, shadowOffset: CGSize(width: 5, height: 5), shadowRadius: 5, shadowColor: .black, shadowOpacity: 1)

        if let fromLayer = fromLayer, layer.sublayers?.first(where: {$0 == fromLayer}) != nil {
            self.layer.replaceSublayer(fromLayer, with: shadowLayer)
        } else {
            self.layer.insertSublayer(shadowLayer, at: 0)
        }

        self.layer.masksToBounds = false

        return shadowLayer
    }
    
    @discardableResult
    public func addShadow(_ fromLayer: CAShapeLayer? = nil, cornerRadius corner: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float) -> CAShapeLayer {

        let shadowLayer = createShadowLayer(cornerRadius: corner, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor, shadowOpacity: shadowOpacity)

        if let fromLayer = fromLayer, layer.sublayers?.first(where: {$0 == fromLayer}) != nil {
            self.layer.replaceSublayer(fromLayer, with: shadowLayer)
        } else {
            self.layer.insertSublayer(shadowLayer, at: 0)
        }

        self.layer.masksToBounds = false

        return shadowLayer
    }
    
    public func addShadow(cornerRadius corner: CGFloat) {
        addShadow(cornerRadius: corner, shadowOffset: CGSize(width: 5, height: 5), shadowRadius: 5)
    }

    public func addShadow(cornerRadius corner: CGFloat, shadowOffset: Int) {
        addShadow(cornerRadius: corner, shadowOffset: CGSize(width: shadowOffset, height: shadowOffset), shadowRadius: 0)
    }

    public func addDefaultShadow(_ shadowLayer: CAShapeLayer?) -> CAShapeLayer {
        return addShadow(shadowLayer, cornerRadius: 8, shadowOffset: CGSize(width: 0, height: 1), shadowRadius: 10, shadowColor: .black, shadowOpacity: 0.1)
    }

    public func removeDefaultShadow(_ shadowLayer: CAShapeLayer?) -> CAShapeLayer {
        let color = UIColor(red:0, green:0, blue:0, alpha: 0)
        return addShadow(shadowLayer, cornerRadius: 8, shadowOffset: CGSize(width: 0, height: 1), shadowRadius: 10, shadowColor: color, shadowOpacity: 0.1)
    }
}
