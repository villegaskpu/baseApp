//
//  UISOMenuIcon.swift
//  SeekOp
//
//  Created by DESARROLLOSICOP on 24/09/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit
protocol UISOMenuIconDelegate {
    func menuPressed(menuIcon: UISOMenuIcon)
}

class UISOMenuIcon: UIView {
    
    private var firstBar: UIView!
    private var secondBar: UIView!
    private var thirdBar: UIView!
    
    var identifier = ""
    var presented = false
    var delegate: UISOMenuIconDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(animate), name: NSNotification.Name(Constants.Observer.menuIconPressed), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.Observer.menuIconPressed), object: nil)
    }
    
    private func customView() {
        backgroundColor = .clear
        let middle = frame.height / 2 - 0.5
        
        firstBar = UIView(frame: CGRect(x: 0, y: middle - 8, width: frame.width, height: 2))
        firstBar.backgroundColor = UIColor.lightBlueGrey
        firstBar.layer.cornerRadius = 1
        addSubview(firstBar)
        
        secondBar = UIView(frame: CGRect(x: 0, y: middle, width: frame.width, height: 2))
        secondBar.backgroundColor = UIColor.lightBlueGrey
        secondBar.layer.cornerRadius = 1
        addSubview(secondBar)
        
        thirdBar = UIView(frame: CGRect(x: 0, y: middle + 8, width: frame.width, height: 2))
        thirdBar.backgroundColor = UIColor.lightBlueGrey
        thirdBar.layer.cornerRadius = 1
        addSubview(thirdBar)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        addGestureRecognizer(tap)
    }
    
    private func degreesToRadians(x: CGFloat) -> CGFloat {
        return (CGFloat.pi * x) / 180
    }
    
    @objc private func tapPressed() {
        delegate?.menuPressed(menuIcon: self)
        animate()
    }
    
    @objc private func animate() {
        
        if presented {
            presented =  false
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.firstBar.transform = CGAffineTransform.identity
                self.thirdBar.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        else {
            presented = true
            
            UIView.animate(withDuration: 0.3) {
                self.firstBar.transform = CGAffineTransform(translationX: 0, y: 8)
                self.thirdBar.transform = CGAffineTransform(translationX: 0, y: -8)
            }
            
            var transform = CGAffineTransform.identity
            transform = transform.rotated(by: degreesToRadians(x: 45))
            transform = transform.scaledBy(x: 0.5, y: 1)
            transform = transform.translatedBy(x: frame.width * 0.75, y: -4)
            
            var transform2 = CGAffineTransform.identity
            transform2 = transform2.rotated(by: degreesToRadians(x: -45))
            transform2 = transform2.scaledBy(x: 0.5, y: 1)
            transform2 = transform2.translatedBy(x: frame.width * 0.75, y: 4)
            
            UIView.animate(withDuration: 0.8, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.firstBar.transform = transform
                self.thirdBar.transform = transform2
            }, completion: nil)
        }
    }
    
    func isPresented() -> Bool {
        return presented
    }
}
