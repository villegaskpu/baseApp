//
//  UIColorExtension.swift
//  Yopter
//
//  Created by Yoptersys on 5/23/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import UIKit

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
