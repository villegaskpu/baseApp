//
//  UIColorExtension.swift
//  Yopter
//
//  Created by Yoptersys on 5/23/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var darkHotPink: UIColor {
        return UIColor(red: 207.0 / 255.0, green: 4.0 / 255.0, blue: 115.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var butterscotch: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 174.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var grapePurple: UIColor {
        return UIColor(red: 117.0 / 255.0, green: 24.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var colorWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    @nonobjc class var lightGreyBlue99: UIColor {
        return UIColor(red: 173.0 / 255.0, green: 185.0 / 255.0, blue: 202.0 / 255.0, alpha: 0.99)
    }
    @nonobjc class var lightGreyBlue: UIColor {
        return UIColor(red: 173.0 / 255.0, green: 185.0 / 255.0, blue: 202.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var maize: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 219.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var colorLightGreyBlue: UIColor {
        return UIColor(red: 164.0 / 255.0, green: 176.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lavender: UIColor {
        return UIColor(red: 199.0 / 255.0, green: 190.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var pinkishGrey: UIColor {
        return UIColor(red: 181.0 / 255.0, green: 179.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var nightBlue: UIColor {
        return UIColor(red: 7.0 / 255.0, green: 16.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var pear: UIColor {
        return UIColor(red: 203.0 / 255.0, green: 239.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    }
//    @nonobjc class var lightGreyBlue: UIColor {
//        return UIColor(red: 147.0 / 255.0, green: 189.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
//    }
    @nonobjc class var silver22: UIColor {
        return UIColor(red: 175.0 / 255.0, green: 222.0 / 255.0, blue: 213.0 / 255.0, alpha: 0.22)
    }
    @nonobjc class var colorBrownGrey: UIColor {
        return UIColor(white: 179.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var metallicBlue20: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 107.0 / 255.0, blue: 126.0 / 255.0, alpha: 0.2)
    }
    @nonobjc class var colorPrimary: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 215.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 235.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var darkGreyBlue70: UIColor {
        return UIColor(red: 49.0 / 255.0, green: 88.0 / 255.0, blue: 86.0 / 255.0, alpha: 0.7)
    }
    @nonobjc class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var brownishOrange: UIColor {
        return UIColor(red: 224.0 / 255.0, green: 109.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmGrey: UIColor {
        return UIColor(white: 153.0 / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            red: CGFloat(1.0) / CGFloat(255.0) * CGFloat(red),
            green: CGFloat(1.0) / CGFloat(255.0) * CGFloat(green),
            blue: CGFloat(1.0) / CGFloat(255.0) * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
