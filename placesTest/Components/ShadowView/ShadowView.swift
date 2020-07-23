//
//  ShadowView.swift
//  placesTest
//
//  Created by André Alves on 23/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

@IBDesignable
open class ShadowView: UIView {

    var shapeLayer: CAShapeLayer?

    @IBInspectable open var heightShadow: CGFloat = 2.0 {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable open var shadowRadius: CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable open var cardView: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    open var desabilitarShadow: Bool = false {
        didSet {
            layoutSubviews()
        }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        if desabilitarShadow {
            shapeLayer = removeDefaultShadow(shapeLayer)
            
            return
        }
        
        if cardView {
            if shadowRadius == 0 {
                shadowRadius = 10
            }
            shapeLayer = addShadow(shapeLayer, cornerRadius: 10, shadowOffset: CGSize(width: 0, height: 1), shadowRadius: shadowRadius, shadowColor: .black, shadowOpacity: 1)
        } else {
            if shadowRadius == 0 {
                shadowRadius = 2
            }
            shapeLayer = addShadow(shapeLayer, cornerRadius: cornerRadius, shadowOffset: CGSize(width: 0, height: heightShadow), shadowRadius: shadowRadius, shadowColor: .black, shadowOpacity: 1)
        }
    }
}
