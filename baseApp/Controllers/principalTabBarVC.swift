//
//  principalTabBarVC.swift
//  baseApp
//
//  Created by David on 8/27/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

class principalTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    func setControllers() {
        let ofertas = OffertsVC()
        ofertas.tabBarItem = UITabBarItem(title: "Ofertas", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_bold"))
        
        
        let favoritos = FavoritosVC()
        favoritos.tabBarItem = UITabBarItem(title: "Favoritas", image: UIImage(named: "star_icon"), selectedImage: UIImage(named: "star_iconBold"))
    
        
        
        self.viewControllers = [ofertas,favoritos]
    }
}
