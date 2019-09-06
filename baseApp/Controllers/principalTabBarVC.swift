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

protocol SOInitAppDelegate {
    func updateMenu(menuItems: InfoManager)
}

class principalTabBarVC: BTabBarVC {

    var capa: UIView!
    var delegateTab:principalTabBarVCDelegate?
    internal let transitionManager = TransitionManagerMenu()
    private var menuDelegate: SOInitAppDelegate?
    internal var menuItems = InfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = UIColor.white
        
        navigationItem.hidesBackButton = true
        initCapa()
        transitionManager.sourceVC = self
        setupNavBar()
        showLoading()
        
        self.hideLoading()
        self.setControllers()
        setItems()
    }
    
    func initCapa() {
        capa = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        capa.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        capa.alpha = 0
        view.addSubview(capa)
    }
    
    private func setItems() {
        menuItems.set(section: "")
        let articulos = InfoItem.init(identifier: "info", type: InfoItemType.default, title: "ARTÍCULOS", value: "ARTÍCULOS")
        articulos.image = UIImage(named: "article_icon")
        
        let ofertas = InfoItem.init(identifier: "ofertas", type: InfoItemType.default, title: "OFERTAS ", value: "OFERTAS ")
        ofertas.image = #imageLiteral(resourceName: "offer_icon")
        
        let contacto = InfoItem.init(identifier: "contacto", type: InfoItemType.default, title: "CONTACTO", value: "CONTACTO")
        contacto.image = #imageLiteral(resourceName: "contacto_icon")
        
        let tutorial = InfoItem.init(identifier: "tutorial", type: InfoItemType.default, title: "TUTORIAL", value: "TUTORIAL")
        tutorial.image = #imageLiteral(resourceName: "tutorial_icon")
        
        let salir = InfoItem.init(identifier: "salir", type: InfoItemType.default, title: "SALIR", value: "SALIR")
        salir.image = #imageLiteral(resourceName: "salir_icon")
        
        menuItems.append(item: articulos)
        menuItems.append(item: ofertas)
        menuItems.append(item: contacto)
        menuItems.append(item: tutorial)
        menuItems.append(item: salir)
        
        self.menuDelegate?.updateMenu(menuItems: self.menuItems)
        
        print("self.menuDelegate: \(self.menuDelegate)")
    }
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = setTitleview()

        let menuButton = UISOMenuIcon(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
        menuButton.delegate = self as? UISOMenuIconDelegate
        
        let left = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = left
        
        let btnDerecho = UIBarButtonItem(image: #imageLiteral(resourceName: "searchbar_icon").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: Any?.self, action: #selector(action))
        
        navigationItem.rightBarButtonItem = btnDerecho

    }
    
    private func setTitleview(logoImage: UIImage? = nil) -> UIView {
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
    
    func setControllers() {
        let ofertas = OffertsVC()
//        ofertas = self
        ofertas.tabBarItem = UITabBarItem(title: "Ofertas", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home_bold")?.withRenderingMode(.alwaysOriginal))
        ofertas.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        ofertas.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        let favoritos = FavoritosVC()
        favoritos.tabBarItem = UITabBarItem(title: "Favoritas", image: UIImage(named: "star_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "star_iconBold")?.withRenderingMode(.alwaysOriginal))
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        let filtros = FiltrosVC()
        filtros.tabBarItem = UITabBarItem(title: "Filtro", image: UIImage(named: "filter_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "filter_iconBold")?.withRenderingMode(.alwaysOriginal))
        filtros.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        filtros.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        
        let Mapa = MapaVC()
        Mapa.view.backgroundColor = UIColor.red
        Mapa.tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "nearby_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "nearby_iconBold")?.withRenderingMode(.alwaysOriginal))
        Mapa.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        Mapa.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        self.tabBar.backgroundColor = UIColor.red
    
        
        
        
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

extension principalTabBarVC{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("presionado: \(item)")
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
    
    @objc func openMenu() {
        let menuVC = Menu(nibName: "Menu", bundle: nil)
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = transitionManager
        menuVC.delegate = self
        menuVC.tableItems = menuItems
        menuDelegate = menuVC
        transitionManager.menuVC = menuVC
//        transitionManager.menuDelegate = menuDelegate
        
        present(menuVC, animated: true, completion: nil)
    }
}

//MARK: OPTION MENU SELECTED
extension principalTabBarVC: MenuDelegate {
    
    func selectedItem(idMenu: String, titulo: String) {
        let vc = TerminosYCondicionesVC()
        
        self.navigationController?.fadeTo(vc)
        if idMenu.elementsEqual("cerrar") {
//            cerrarSesion()
        }
        else {
//            Navigation.push(idMenu: idMenu, target: self, titulo: titulo)
        }
    }
}
