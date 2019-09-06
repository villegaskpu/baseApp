//
//  TransitionManager.swift
//  AdvancedTransition
//
//  Created by Daniel Rodriguez on 03/11/17.
//  Copyright © 2017 Sicop Consulting, S.A. de C.V. All rights reserved.
//

import UIKit

class TransitionManagerMenu: UIPercentDrivenInteractiveTransition {
    
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    private var presenting = true
    private var interactive = false
    private var menuWidth: CGFloat = Device.iPad ? 350 : Screen.width * 0.85
    
    var menuDelegate: SOInitAppDelegate?
    var menuItems: InfoManager!
    var sourceVC: principalTabBarVC! {
        didSet {
            enterPanGesture = UIScreenEdgePanGestureRecognizer()
            enterPanGesture.addTarget(self, action: #selector(panGestureHandler(_:)))
            enterPanGesture.edges = .left
            sourceVC.view.addGestureRecognizer(enterPanGesture)
        }
    }
    var menuVC: Menu! {
        didSet {
            panGesture = UIPanGestureRecognizer()
            panGesture.addTarget(self, action: #selector(panGestureHandler2(_:)))
            menuVC.view.addGestureRecognizer(panGesture)
            menuVC.constraintView.constant = menuWidth
        }
    }
    
    @objc private func panGestureHandler(_ pan: UIScreenEdgePanGestureRecognizer) {
        
        let translation = pan.translation(in: pan.view!)
        let d =  (translation.x) / menuWidth
        
        switch (pan.state) {
        case .began:
            interactive = true
            
//            let vc = Menu(nibName: "Menu", bundle: nil)
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.transitioningDelegate = self
//            vc.delegate = sourceVC
//            vc.tableItems = menuItems
//            menuDelegate = vc
//            menuVC = vc
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            sourceVC.present(vc, animated: true, completion: nil)
            break
        case .changed:
            
            if d >= 0 && d <= 1 {
                update(d)
            }
            
            break
        default:
            interactive = false
            
            if d < 0.3 {
                cancel()
            }
            else {
                finish()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observer.menuIconPressed), object: nil)
            }
            
            break
        }
    }
    
    @objc private func panGestureHandler2(_ pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: pan.view!)
        let d =  -translation.x / menuWidth
        
        switch (pan.state) {
        case .began:
            interactive = true
            menuVC.dismiss(animated: true, completion: nil)
            
            break
        case .changed:
            print(d)
            
            if d >= 0 && d <= 1 {
                update(d)
            }
            
            break
        default:
            interactive = false
            
            if d < 0.3 {
                
                UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
                    self.cancel()
                }, completion: nil)
            }
            else {
                finish()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observer.menuIconPressed), object: nil)
            }
            
            break
        }
    }
}


extension TransitionManagerMenu: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        presenting = false
        
        return self
    }
}

extension TransitionManagerMenu {
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self : nil
    }
}

extension TransitionManagerMenu: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //PARA CREAR LA ANIMACIÓN
        
        let container = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        if presenting {
            let toView = transitionContext.viewController(forKey: .to)!
            let fromRoot = sourceVC.viewControllers![0]
            container.addSubview(toView.view)
            
            toView.view.frame = fromRoot.view.frame
            toView.view.transform = CGAffineTransform(translationX: -menuWidth, y: 0.0)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.sourceVC.capa.alpha = 1.0
                toView.view.transform = CGAffineTransform.identity
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        else {
            let fromView = transitionContext.viewController(forKey: .from)!
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.sourceVC.capa.alpha = 0.0
                fromView.view.transform = CGAffineTransform.identity
                fromView.view.transform = CGAffineTransform(translationX: -self.menuWidth, y: 0.0)
                
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
}

