//
//  principalTabBarVC.swift
//  baseApp
//
//  Created by David on 8/27/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import CoreLocation

protocol principalTabBarVCDelegate {
    func setParameters(parametares: [String:Any])
}

class principalTabBarVC: BTabBarVC {

    var delegateTab:principalTabBarVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        self.view.backgroundColor = UIColor.white
        showLoading()
        
        self.hideLoading()
        self.setControllers()
    }
    
    func setControllers() {
        let ofertas = OffertsVC()
//        ofertas = self
        ofertas.tabBarItem = UITabBarItem(title: "Ofertas", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_bold"))
        
        let favoritos = FavoritosVC()
        favoritos.tabBarItem = UITabBarItem(title: "Favoritas", image: UIImage(named: "star_icon"), selectedImage: UIImage(named: "star_iconBold"))
        
        let filtros = FiltrosVC()
        filtros.tabBarItem = UITabBarItem(title: "Filtro", image: UIImage(named: "filter_icon"), selectedImage: UIImage(named: "filter_iconBold"))
        
        
        let Mapa = MapaVC()
        Mapa.view.backgroundColor = UIColor.red
        Mapa.tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "nearby_icon"), selectedImage: UIImage(named: "nearby_iconBold"))
    
        self.viewControllers = [ofertas,filtros,favoritos, Mapa]
    }
}

extension principalTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 1
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}

extension principalTabBarVC{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("presionado: \(item)")
    }
}
