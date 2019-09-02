//
//  HomeVC.swift
//  baseApp
//
//  Created by David on 8/29/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

class HomeVC: BViewController {
    
    @IBOutlet weak var bgDark: UIImageView!
    @IBOutlet weak var HomeLogo: UIImageView!
    
    @IBOutlet weak var btnIniciarSesionO: UIButton!
    
    @IBOutlet weak var btnRegistrarseO: UIButton!
    
    
    @IBOutlet weak var lVersion: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        lVersion.font = UIFont(name: Font.FONT_REGULAR(), size: Font.SIZE_FONT_REGULAR())
        lVersion.adjustsFontSizeToFitWidth = true
        lVersion.minimumScaleFactor = 0.5
        lVersion.text = Commons.version()
    }
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        print("btnIniciarSesion")
        btnIniciarSesionO.pulsate()
        let vc = LoginVC()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnRegistrarse(_ sender: Any) {
        print("btnRegistrarse")
        btnRegistrarseO.pulsate()
        let vc = RegistroVC()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.fadeTo(vc)
        }
    }
}
