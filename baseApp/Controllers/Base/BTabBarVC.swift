//
//  BTabBarVC.swift
//  baseApp
//
//  Created by David on 9/4/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol SOInitAppDelegate {
    func updateMenu(menuItems: InfoManager)
}

protocol principalTabBarVCDelegate {
    func btnSearchPress()
    func aplicarFiltros(idFiltro: String)
}

class BTabBarVC: UITabBarController {

    private let loadingContainer = UIView()
    private var messageView = UIView()
    private var menuDelegate: SOInitAppDelegate?
    var delegateTab:principalTabBarVCDelegate?
    
    internal var menuItems = InfoManager()
    internal let transitionManager = TransitionManagerMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMenu()
    }
    
    
    func finishLoading() {
        //hideLoading()
    }
    
    
    @objc func openMenu() {
        let menuVC = Menu2(nibName: "Menu", bundle: nil)
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = transitionManager
        menuVC.delegate = self
        menuVC.tableItems = menuItems
        menuDelegate = menuVC
        transitionManager.menuVC = menuVC
        transitionManager.menuDelegate = menuDelegate
        
        present(menuVC, animated: true, completion: nil)
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = setTitleview()
        
//        let menuButton = UISOMenuIcon(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
//        menuButton.delegate = self as? UISOMenuIconDelegate
        
        
        let btnIzquierdo = UIBarButtonItem(image: #imageLiteral(resourceName: "MenuBTN").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), style: UIBarButtonItem.Style.plain, target: self, action: #selector(irAMenu))
        
//        let left = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = btnIzquierdo
        navigationItem.leftBarButtonItem?.tintColor = UIColor.lightBlueGrey
        
        let btnDerecho = UIBarButtonItem(image: #imageLiteral(resourceName: "searchbar_icon").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), style: UIBarButtonItem.Style.plain, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = btnDerecho
        navigationItem.rightBarButtonItem?.tintColor = UIColor.lightBlueGrey
        
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.tabBarController?.tabBar.layer.shadowOpacity = 1
        self.tabBarController?.tabBar.layer.masksToBounds = false
    }
    
    @objc func irAMenu() {
        self.navigationController?.navigationBar.isHidden = true
        let vc = menuLateralVC()
        self.navigationController?.moveIn(vc)
    }
    
    @objc func action(sender: UIBarButtonItem) {
        delegateTab?.btnSearchPress()
    }
    
    private func setupMenu() {
        menuItems.set(section: "")
        let articulos = InfoItem.init(identifier: "articulos", type: InfoItemType.default, title: "ARTÍCULOS", value: "ARTÍCULOS")
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
    
    
}

//MARK: OPTION MENU SELECTED
extension BTabBarVC: MenuDelegate {
    
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
        
//        if idMenu.elementsEqual("cerrar") {
////            cerrarSesion()
//        }
//        else {
////            Navigation.push(idMenu: idMenu, target: self, titulo: titulo)
//        }
    }
}
