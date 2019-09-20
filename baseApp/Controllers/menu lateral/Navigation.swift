//
//  Navigation.swift
//  baseApp
//
//  Created by David on 9/18/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


class Navigation: NSObject {
    
    static func push(idMenu: String, target: UIViewController, titulo: String, item:InfoItem) {
        var viewController: UIViewController?
        
        switch item.identifier {
        case "1":
            let op = item.webView.toInt() ?? 0
//            if op == 1 { // interna
//
//            } else {
                let svc = SFSafariViewController.init(url: URL.init(string:item.urlWebView)!)
                target.present(svc, animated: true, completion: nil)
//            }
            break
        case "terminos":
            let vc = TerminosYCondicionesVC()
            viewController = vc
            break
        case "2":
            let vc = principalTabBarVC()
            viewController = vc
            break
        case "3","0":
            let vc = principalTabBarArticulosVC()
            viewController = vc
        case "4":
            Commons.sendEmail(target: target)
            break
        default:
            break
        }
        
        if let vc_ = viewController {
            target.navigationController?.fadeTo(vc_)
        }
    }
    
    
}
extension UINavigationController {
    
//    func returnCumplirSeg(vcR:UIViewController) {
//
//
//        let vcs = viewControllers.filter({ $0 is vcR })
//
//        if let menuVC = vcs.first {
//            popToViewController(menuVC, animated: true)
//        }
//    }
//
//    func backToViewController(viewController: Swift.AnyClass) {
//
//        for element in viewControllers as Array {
//            if element.isKind(of: viewController) {
//                self.popToViewController(element, animated: true)
//                break
//            }
//        }
//    }
}
