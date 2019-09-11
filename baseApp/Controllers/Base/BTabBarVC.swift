//
//  BTabBarVC.swift
//  baseApp
//
//  Created by David on 9/4/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BTabBarVC: UITabBarController {

    private let loadingContainer = UIView()
    private var messageView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoading(overCurrentContext: Bool = false) {
        
        for subview in loadingContainer.subviews {
            subview.removeFromSuperview()
        }
        
        loadingContainer.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        loadingContainer.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        loadingContainer.alpha = 0.0
        
        let frameAct = CGRect(x: Screen.width/2 - 20.0, y: Screen.height/2, width: 40.0, height: 40.0)
        
        let actv = NVActivityIndicatorView(frame: frameAct, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.hexStringToUIColor(hex: "#20476E"), padding: 0.0)
        actv.startAnimating()
        
        loadingContainer.addSubview(actv)
        
        if overCurrentContext {
            if let w = UIApplication.shared.keyWindow {
                w.addSubview(loadingContainer)
            }
        }
        else {
            view.addSubview(loadingContainer)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingContainer.alpha = 1.0
        })
    }
    
    
    func hideLoading() {
        UIView.animate(withDuration: 0.8, animations: {
            self.loadingContainer.alpha = 0.0
        },completion: { void in
            self.loadingContainer.removeFromSuperview()
        })
    }
    
    func setTitleview(logoImage: UIImage? = nil) -> UIView {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        titleView.backgroundColor = .clear
        
        var image = #imageLiteral(resourceName: "homeLogo")
        
        if let img = logoImage {
            image = img
        }
        
        let logo = UIImageView(image: image)
        logo.contentMode = .scaleAspectFit
        logo.frame = titleView.bounds
        
        titleView.addSubview(logo)
        
        return titleView
    }
}
