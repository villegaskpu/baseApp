//
//  principalTabBsrArticulosVC.swift
//  baseApp
//
//  Created by David on 9/9/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

class principalTabBarArticulosVC: BTabBarVC {
    
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
        transitionManager.sourceVC2 = self
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
    }
    
    func setControllers() {
        let articulos = ArticulosVC()
        //        ofertas = self
        articulos.tabBarItem = UITabBarItem(title: "Artículos", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home_bold")?.withRenderingMode(.alwaysOriginal))
        articulos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        articulos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        let favoritos = FavoritosVC()
        favoritos.tabBarItem = UITabBarItem(title: "Favoritas", image: UIImage(named: "star_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "star_iconBold")?.withRenderingMode(.alwaysOriginal))
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        favoritos.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.maize], for: .selected)
        
        self.viewControllers = [articulos,favoritos]
    }
    
    // MARK: STATUS BAR STYLE CONTROL
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension principalTabBarArticulosVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}



extension principalTabBarArticulosVC{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("presionado: \(item)")
    }
}

extension principalTabBarArticulosVC: UISOMenuIconDelegate {
    
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
extension principalTabBarArticulosVC: MenuDelegate {
    
    func selectedItem(idMenu: String, titulo: String) {
        
        if idMenu.elementsEqual("terminos") {
            let vc = TerminosYCondicionesVC()
            self.navigationController?.fadeTo(vc)
        }
        else if idMenu.elementsEqual("ofertas") {
            let vc = principalTabBarVC()
            self.navigationController?.fadeTo(vc)
        }
        else if idMenu.elementsEqual("terminos") {
            let vc = TerminosYCondicionesVC()
            self.navigationController?.fadeTo(vc)
        }
        else {
            //            Navigation.push(idMenu: idMenu, target: self, titulo: titulo)
        }
    }
}
