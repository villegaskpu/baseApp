////
////  SOInitApp.swift
////  SeekOp
////
////  Created by DESARROLLOSICOP on 26/07/18.
////  Copyright © 2018 David Villegas Santana. All rights reserved.
////
//
//import UIKit
//
////protocol SOInitAppDelegate {
////    func updateMenu(menuItems: InfoManager)
////}
//
//class SOInitApp: UITabBarController, UITabBarControllerDelegate {
//
//    private var notificationManager: NotificationManager!
//    private var performanceDigitalName = ""
//    private var publicacionName = ""
//    private var menuDelegate: SOInitAppDelegate?
//
//    internal var menuItems = InfoManager()
//    internal let transitionManager = TransitionManagerMenu()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        delegate = self
//        navigationItem.hidesBackButton = true
//
//        setupNavBar()
//        setupObservers()
//        validaNotificaciones()
//        getWSVersion()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//
//
////    private func validaNotificaciones() {
////        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
////        if !isRegisteredForRemoteNotifications {
////            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
////                let alert = SeekOpAlerts(title: "Aviso", message: "Tus notificaciones no están activas. Esto es importante para que puedas recibir toda la información de Sicop.", buttonTitle: "Ir a configuración")
////                alert.identifier = "config"
////                alert.delegate = self
////                alert.presentAlert()
////            }
////        }
////    }
//
//    private func getWSVersion() {
//
////        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
////
////            let service = Network()
////            service.set("VersionWebservice")
////            service.set(parameter: "IdAplicacion", value: "00000002")
////            service.set(parameter: "Origen", value: "3")
////            service.set(parameter: "Version", value: version)
////            service.set(parser: InitParser())
////            service.read { response in
////
////                if let wsVersion = response as? String {
////                    Webservice.setup(wsVersion)
////                }
////
////                self.setupMenu()
////            }
////        }
////        else {
//            setupMenu()
////        }
//    }
//
//    @objc func openMenu() {
//        let menuVC = Menu(nibName: "Menu", bundle: nil)
//        menuVC.modalPresentationStyle = .overCurrentContext
//        menuVC.transitioningDelegate = transitionManager
//        menuVC.delegate = self
//        menuVC.tableItems = menuItems
//        menuDelegate = menuVC
//        transitionManager.menuVC = menuVC
//        transitionManager.menuDelegate = menuDelegate
//
//        present(menuVC, animated: true, completion: nil)
//    }
//
//    private func setupNavBar() {
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
//        navigationController?.isNavigationBarHidden = false
//        navigationItem.titleView = setTitleview()
//
//        let menuButton = UISOMenuIcon(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
//        menuButton.delegate = self as? UISOMenuIconDelegate
//
//        let left = UIBarButtonItem(customView: menuButton)
//        navigationItem.leftBarButtonItem = left
//
//        let btnDerecho = UIBarButtonItem(image: #imageLiteral(resourceName: "searchbar_icon").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), style: UIBarButtonItem.Style.plain, target: self, action: #selector(action))
//        navigationItem.rightBarButtonItem = btnDerecho
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.lightBlueGrey
//
//        self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
//        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.tabBarController?.tabBar.layer.shadowOpacity = 1
//        self.tabBarController?.tabBar.layer.masksToBounds = false
//    }
//
//    private func setupMenu() {
//        menuItems.set(section: "")
//        let articulos = InfoItem.init(identifier: "articulos", type: InfoItemType.default, title: "ARTÍCULOS", value: "ARTÍCULOS")
//        articulos.image = UIImage(named: "article_icon")
//
//        let ofertas = InfoItem.init(identifier: "ofertas", type: InfoItemType.default, title: "OFERTAS ", value: "OFERTAS ")
//        ofertas.image = #imageLiteral(resourceName: "offer_icon")
//
//        let contacto = InfoItem.init(identifier: "contacto", type: InfoItemType.default, title: "CONTACTO", value: "CONTACTO")
//        contacto.image = #imageLiteral(resourceName: "contacto_icon")
//
//        let tutorial = InfoItem.init(identifier: "tutorial", type: InfoItemType.default, title: "TUTORIAL", value: "TUTORIAL")
//        tutorial.image = #imageLiteral(resourceName: "tutorial_icon")
//
//        let salir = InfoItem.init(identifier: "salir", type: InfoItemType.default, title: "SALIR", value: "SALIR")
//        salir.image = #imageLiteral(resourceName: "salir_icon")
//
//        menuItems.append(item: articulos)
//        menuItems.append(item: ofertas)
//        menuItems.append(item: contacto)
//        menuItems.append(item: tutorial)
//        menuItems.append(item: salir)
//        self.menuDelegate?.updateMenu(menuItems: self.menuItems)
//    }
//
////    private func setupObservers() {
////        setObserver(name: Constants.Observer.backgroundNotification, selector: #selector(onBackgroundNotificationReceived(_:)))
////        setObserver(name: Constants.Observer.foregroundNotification, selector: #selector(onForegroundNotificationReceived(_:)))
////        //setObserver(name: SHOW_NEWS, selector: #selector(verifyViewController))
////
//////        setObserver(name: "captura", selector: #selector(captura3D))
//////        setObserver(name: "buscar", selector: #selector(buscar3D))
//////        setObserver(name: "correo", selector: #selector(correo3D))
//////        setObserver(name: "noticias", selector: #selector(noticias3D))
//////        setObserver(name: "chat", selector: #selector(chat3D))
////    }
//
//    private func setTitleview(logoImage: UIImage? = nil) -> UIView {
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
//        titleView.backgroundColor = .clear
//
//        var image = #imageLiteral(resourceName: "homeLogo")
//
//        if let img = logoImage {
//            image = img
//        }
//
//        let logo = UIImageView(image: image)
//        logo.contentMode = .scaleAspectFit
//        logo.frame = titleView.bounds
//
//        titleView.addSubview(logo)
//
//        return titleView
//    }
//
//
//
//    @objc private func downloadNewVersion() {
//        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1154300334"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//    }
//
//    private func removeObserver(name: String) {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
//    }
//
//    private func setObserver(name: String, selector: Selector) {
//        removeObserver(name: name)
//        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
//    }
//
//    //MARK: NOTIFICACIONES
//    @objc func onBackgroundNotificationReceived(_ notificacion: Notification) {
//        performNotification(notificacion, type: .background)
//    }
//
//    @objc func onForegroundNotificationReceived(_ notificacion: Notification) {
//        performNotification(notificacion, type: .foreground)
//    }
//
//    private func performNotification(_ notificacion: Notification, type: NotificationType) {
//        UIApplication.shared.applicationIconBadgeNumber = 0
//        notificationManager = NotificationManager(notificacion, type: type, vc: self)
//        notificationManager.doAction()
//    }
//
//    //MARK: CERRAR SESION
//    @objc func cerrarSesion() {
//        removeAllShorcutItems()
//        removeObserver(name: Constants.Observer.backgroundNotification)
//        removeObserver(name: Constants.Observer.foregroundNotification)
//        removeObserver(name: SHOW_NEWS)
//
//        navigationController?.popViewController(animated: true)
//    }
//
//    func finishLoading() {
//        //hideLoading()
//    }
//}
//
//
////MARK: OPTION MENU SELECTED
//extension SOInitApp: MenuDelegate {
//
//    func selectedItem(idMenu: String, titulo: String) {
//
//        if idMenu.elementsEqual("cerrar") {
//            cerrarSesion()
//        }
//        else {
//            Navigation.push(idMenu: idMenu, target: self, titulo: titulo)
//        }
//    }
//}
