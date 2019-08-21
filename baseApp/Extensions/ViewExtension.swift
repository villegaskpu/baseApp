//
//  ViewExtension.swift
//  Yopter
//
//  Created by Yoptersys on 5/23/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import UIKit

extension UIView{
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 10
    }
    
    func shadow(height: CGFloat = 0.5, width: CGFloat = 1.5, shadowOpacity: Float = 0.2, cornerRadius: CGFloat = 0.0, shadowRadius: CGFloat = 3.0, color: UIColor = .black) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.cornerRadius = cornerRadius
    }
}
