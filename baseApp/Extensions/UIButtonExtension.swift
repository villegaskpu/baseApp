//
//  UIButtonExtension.swift
//  baseApp
//
//  Created by David on 8/29/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func initButton(boton: UIButton, backgroundColor: UIColor = UIColor.blue, textColor: UIColor = UIColor.white, image:String = "btnEnter") {
        
        boton.setBackgroundImage(UIImage(named: image), for: .normal)
        boton.setTitleColor(textColor, for: UIControl.State())
        boton.setTitleColor(UIColor.darkGray, for: .selected)
        boton.setTitleColor(UIColor.darkGray, for: .highlighted)
//        boton.backgroundColor = backgroundColor
        boton.titleLabel?.font = UIFont(name: Font.FONT_BOLD(), size: Font.SIZE_FONT_BOLD())
//        boton.layer.masksToBounds = false
//        boton.layer.shadowColor = UIColor.black.cgColor
//        boton.layer.shadowOpacity = 0.5
        
        if let text = boton.titleLabel?.text?.capitalized {
            boton.setTitle(text, for: .normal)
        }
        
//        boton.layer.shadowRadius = 1.5
//        boton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        boton.layer.cornerRadius = 6.0
//        boton.layer.borderWidth = 0.0
//        boton.layer.borderColor = UIColor.white.cgColor
//        boton.setTitleColor(UIColor.gray, for: .disabled)
    }
}
