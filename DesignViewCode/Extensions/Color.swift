//
//  Color.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 11/11/23.
//

import UIKit

extension UIColor {
    static func setHexColor(hex: Int, opacity: Float) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(opacity))
    }
    static func setRGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: Float) -> UIColor {
        let red = red / 255
        let green = green / 255
        let blue = blue / 255

        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(opacity))
    }
}
