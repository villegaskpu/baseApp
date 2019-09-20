//
//  principalTabBarVC.swift
//  baseApp
//
//  Created by David on 8/27/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import CoreLocation

class principalTabBarVC: BTabBarVC {

    var capa: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = UIColor.white
        
        navigationItem.hidesBackButton = true
        initCapa()
        transitionManager.sourceVC = self
        self.setControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func finishLoading() {
        transitionManager.menuItems = menuItems
    }
    
    func initCapa() {
        capa = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        capa.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        capa.alpha = 0
        view.addSubview(capa)
    }
    
    func setControllers() {
        let ofertas = OffertsVC()
        self.delegateTab = ofertas
        ofertas.tabBarItem = UITabBarItem(title: "Ofertas", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home_bold")?.withRenderingMode(.alwaysOriginal))
        ofertas.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        ofertas.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        let favoritos = FavoritosVC()
        favoritos.tabBarItem = UITabBarItem(title: "Favoritas", image: UIImage(named: "star_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "star_iconBold")?.withRenderingMode(.alwaysOriginal))
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        let filtros = FiltrosVC()
        filtros.delegate = self
        filtros.tabBarItem = UITabBarItem(title: "Filtro", image: UIImage(named: "filter_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "filter_iconBold")?.withRenderingMode(.alwaysOriginal))
        filtros.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        filtros.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        
        let Mapa = MapaVC()
        Mapa.view.backgroundColor = UIColor.red
        Mapa.tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "nearby_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "nearby_iconBold")?.withRenderingMode(.alwaysOriginal))
        Mapa.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        Mapa.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        self.viewControllers = [ofertas,filtros,favoritos, Mapa]
    }
    
    // MARK: STATUS BAR STYLE CONTROL
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension principalTabBarVC: UISOMenuIconDelegate {
    
    func menuPressed(menuIcon: UISOMenuIcon) {
        if menuIcon.isPresented() {
            transitionManager.menuVC.dismiss(animated: true, completion: nil)
        }
        else {
            openMenu()
        }
    }
}

extension principalTabBarVC{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let indexOfTab = tabBar.items?.index(of: item){
            if indexOfTab == 0 {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightBlueGrey
            }
            else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            }
            print("pressed tabBar: \(String(describing: indexOfTab))")
        }
    }
}

extension principalTabBarVC: FiltrosVCDelegate {
    func returnFiltros(menuFiltro: String) {
        print("filtroSeleccionado: \(menuFiltro)")
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightBlueGrey
        delegateTab?.aplicarFiltros(idFiltro: menuFiltro)
    }
}
