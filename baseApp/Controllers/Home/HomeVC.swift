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
    
    @IBOutlet weak var lNoTienesCuenta: UILabel!
    
    @IBOutlet weak var txtWelcome: UILabel!
    
    @IBOutlet weak var lTitulos: UILabel!
    
    
    @IBOutlet weak var btnIniciarSesionO: UIButton!
    
    @IBOutlet weak var btnRegistrarseO: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.reachability.startNotifier()
        setAttributedText()
        
    }
    
    
    
    @objc func reachabilityChanged(_ notification : Notification)
    {
        let reacha = notification.object as! Reachability
        switch(reacha.currentReachabilityStatus())
        {
        case NotReachable:
            //Commons.showMessage("Conexión a internet no disponible, intenta más tarde")
            Commons.windowInternetError(action: nil, target: self)
        default:
            Commons.removeWindowInternetError()
        }
    }
    
    private func setAttributedText() {
        let attributedString = NSMutableAttributedString(string: "No tienes una cuenta?  Crear cuenta", attributes: [
            .font: UIFont(name: "Roboto-Bold", size: 13.0)!,
            .foregroundColor: UIColor.white,
            .kern: -0.21
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Regular", size: 13.0)!, range: NSRange(location: 23, length: 12))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 23, length: 12))
        
        lNoTienesCuenta.attributedText = attributedString
        
        
        txtWelcome.font = UIFont.textWelcome
        txtWelcome.textColor = UIColor.colorWhite
        txtWelcome.shadow(height: 4, width: 2, shadowOpacity: 1.0, cornerRadius: 1.0, shadowRadius: 2.0, color: UIColor.black)
        
        lTitulos.font = UIFont.titulos
        lTitulos.textColor = UIColor.colorWhite
        
        lTitulos.shadow(height: 2, width: 2, shadowOpacity: 1.0, cornerRadius: 1.0, shadowRadius: 3.0, color: UIColor.black.withAlphaComponent(0.5))
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
        let vc = RegistroVC()
        self.navigationController?.fadeTo(vc)
    }
}
