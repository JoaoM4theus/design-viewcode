//
//  CustomView.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/1/21.
//

import UIKit

@IBDesignable
final class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: Int = 0 {
        didSet {
            layer.shadowOffset = CGSize(width: 0, height: shadowOffset)
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    func configureDefault() {
        cornerRadius = 30
        shadowOpacity = 0.5
        shadowOffset = 10
        shadowColor = UIColor(named: "Shadow")!
        shadowRadius = 20
        borderWidth = 1
        let color: UIColor = .setHexColor(hex: 0x000000, opacity: 0.2)
        borderColor = color
    }
    
}
