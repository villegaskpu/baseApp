//
//  Funciones.swift
//  baseApp
//
//  Created by David on 9/5/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit

class Funciones {
    
    static public func addShadow(view: UIView?, height: CGFloat = 0.5, width: CGFloat = 1.5, shadowOpacity: CGFloat = 0.2, cornerRadius: CGFloat = 0.0, shadowRadius: CGFloat = 6.0, color: UIColor = .black) {
        
        view?.layer.masksToBounds = false
        view?.layer.shadowColor = color.cgColor
        view?.layer.shadowOpacity = Float(shadowOpacity)
        view?.layer.shadowRadius = shadowRadius
        view?.layer.shadowOffset = CGSize(width: width, height: height)
        view?.layer.cornerRadius = cornerRadius
    }
}
