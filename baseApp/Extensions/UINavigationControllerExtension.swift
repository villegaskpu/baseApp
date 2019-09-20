//
//  UINavigationControllerExtension.swift
//  baseApp
//
//  Created by David on 9/2/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.9
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func moveIn(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.9
        transition.type = CATransitionType.moveIn
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
