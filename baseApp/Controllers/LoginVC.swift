//
//  LoginVC.swift
//  baseApp
//
//  Created by David on 8/9/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import a4SysCoreIOS
import Alamofire
import ObjectMapper
import CoreLocation

class LoginVC: BViewController {
    
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var viewTextFiels: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var recuperarContraseña: UIButton!
    @IBOutlet weak var ingresoAnonimo: UIButton!
    @IBOutlet weak var crearCuenta: UIButton!
    
    
    @IBOutlet weak var tCorreoElectronico: UILabel!
    @IBOutlet weak var tContraseñaText: UILabel!
    @IBOutlet weak var txtBienvenida: UILabel!
    
    var buttonEye = UIButton()
    
    var showPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCorreo.text = "vycotic1@yopmail.com"
        txtPassword.text = "Yopter1."
        setStyle()
        setEyeIcon()
        animateView(viewA: homeLogo, point: CGPoint(x: homeLogo.center.x - 150, y: homeLogo.center.y))
        animateView(viewA: viewTextFiels, point: CGPoint(x: viewTextFiels.center.x , y: viewTextFiels.center.y - 300))
        animateButtonLogin()
    }
    
    private func setEyeIcon() {
        buttonEye = UIButton(type: .custom)
        buttonEye.setImage(UIImage(named: "IconEye")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        buttonEye.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        buttonEye.frame = CGRect(x: CGFloat(txtPassword.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        buttonEye.addTarget(self, action: #selector(self.showPasword), for: .touchUpInside)
        buttonEye.tintColor = UIColor.black
        buttonEye.imageView?.tintColor = UIColor.black
        txtPassword.rightView = buttonEye
        txtPassword.rightViewMode = .always
    }
    
    @objc func showPasword() {
        
        if showPassword { // es visible
            print("visible")
            buttonEye.setImage(UIImage(named: "IconEye") , for: .normal)
            txtPassword.isSecureTextEntry = true
            showPassword = false
        } else { // esta oculto
            print("oculto")
            buttonEye.setImage(UIImage(named: "IconEyeOff") , for: .normal)
            showPassword = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
    
    
    private func setStyle() {
        
        tCorreoElectronico.font = UIFont.labelWhite
        tCorreoElectronico.textColor = UIColor.black
        
        tContraseñaText.font = UIFont.labelWhite
        tContraseñaText.textColor = UIColor.black
        
        
        txtBienvenida.font = UIFont.textStyle3
        txtBienvenida.textColor = UIColor.black
        
        
        
        recuperarContraseña.titleLabel?.adjustsFontSizeToFitWidth = true
        ingresoAnonimo.titleLabel?.adjustsFontSizeToFitWidth = true
        crearCuenta.titleLabel?.adjustsFontSizeToFitWidth = true
        
        recuperarContraseña.titleLabel?.minimumScaleFactor = 0.3
        ingresoAnonimo.titleLabel?.minimumScaleFactor = 0.3
        crearCuenta.titleLabel?.minimumScaleFactor = 0.3
        
        txtCorreo.adjustsFontSizeToFitWidth = true
        txtCorreo.minimumFontSize = 0.3
        
        txtPassword.adjustsFontSizeToFitWidth = true
        txtPassword.minimumFontSize = 0.3
        
        let attributedString = NSAttributedString(string: "Recuperar contraseña", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        recuperarContraseña.titleLabel?.textColor = UIColor.white
        recuperarContraseña.titleLabel?.font = UIFont.linkWhite
        recuperarContraseña.titleLabel?.attributedText = attributedString
        
        
        let attributedString2 = NSAttributedString(string: "|  Crear cuenta", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        crearCuenta.titleLabel?.textColor = UIColor.white
        crearCuenta.titleLabel?.font = UIFont.linkWhite
        crearCuenta.titleLabel?.attributedText = attributedString2
        
        let attributedString3 = NSAttributedString(string: "|  Ingreso anónimo ", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        ingresoAnonimo.titleLabel?.textColor = UIColor.white
        ingresoAnonimo.titleLabel?.font = UIFont.linkWhite
        ingresoAnonimo.titleLabel?.attributedText = attributedString3
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    private func animateView(viewA: AnyObject, point: CGPoint) {
        let viewb = viewA as? UIView ?? UIView()
        viewb.alpha = 0.7
        let newCenter = point
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveLinear, animations: {
            viewb.center = newCenter
        }) { (success: Bool) in
            print("Done moving image")
            viewb.alpha = 1.0
        }
    }
    
    
    private func animateButtonLogin() {
        btnLogin.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 1.3) {
                self.btnLogin.alpha = 1
            }
        }
    }
    
    @IBAction func btnEntrar(_ sender: Any) {
        showLoading()
        self.view.endEditing(true)
        if validateForm() {
            let network = Network()
            network.setConstants(constants: constantsParameters)
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setUrlParameters(urlParameters: Requests.createLoginRequest(txtCorreo.text!, txtPassword.text!, userAgent: Commons.getUserAgent()))
            network.endPointN(endPont: .Login) { (statusCode, value, objeto) -> (Void) in
                let statusC = statusCode.toInt() ?? 0
                
                if statusC >= 200 && statusC < 300 {
                    print("ya estufas: \(value)")
                    if let obj = objeto as? LoginResponse { // no se forsa el cast para evitar que truene el app
                        print("SetValues")
                        DispatchQueue.main.async {
                            Settings.sharedInstance.setSesion(true)
                            Settings.sharedInstance.setUsername(value: self.txtCorreo.text!)
                            Settings.sharedInstance.setPassword(value: self.txtPassword.text!)
                            Settings.sharedInstance.setToken(value: obj.token ?? "")
                            Settings.sharedInstance.setOldToken(value: obj.tokenYopter ?? "")
                            Settings.sharedInstance.setAnonymous(value: "false")
                            print("SetValues: \(Settings.sharedInstance.getOldToken())")
                            print("SetValuesTOKENNEW: \(Settings.sharedInstance.getToken())")
                            
                            constantsParameters = [ "appID" : "1ed3d6e03ee03c04bf3365f808fc28f1",
                            "token" : "\(Settings.sharedInstance.getToken() ?? "")",
                            "tokenYopter" : "\(Settings.sharedInstance.getOldToken() ?? "")"
                            ]
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            let vc = TemporalHome()
                            self.navigationController?.fadeTo(vc)
                        })
                    } else {
                        Commons.showMessage("Error de comunicación")
                    }
                }else {
                    if let obj = objeto as? ApiError {
                        if obj.code == "500" {
                            Commons.showMessage("GLOBAL_ERROR".localized, duration: .long)
                        } else {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        }
                    } else {
                        Commons.showMessage("Error de comunicación")
                    }
                }
                self.hideLoading()
            }
        } else {
            self.hideLoading()
        }
    }
    
    
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        let vc = RegistroVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnRecuperarPassword(_ sender: Any) {
        print("recuperar pasword")
    }
    
    
    @IBAction func btnIngresoAnonimo(_ sender: Any) {
        print("ingreso anonimo")
    }
    
    
    // MARK: VALIDATE FORM
    
    func validateForm() -> Bool
    {
        if self.txtCorreo.text == nil || self.txtCorreo.text == "" {
            Commons.showMessage("INVALID_EMAIL".localized)
            return false
        }
        else if self.txtPassword.text == nil || self.txtPassword.text == "" {
            Commons.showMessage("MISSING_PASSWORD".localized)
            return false
        }
        else if (self.txtPassword.text?.count)! < 6 {
            Commons.showMessage("MISSING_INFO".localized)
            return false
        }
        return true
    }
}
extension LoginVC : LocationUtilDelegate {
    // MARK: LOCATION DELEGATE
    func tracingLocation(currentLocation: CLLocation) {
        LocationUtil.sharedInstance.currentLocation = currentLocation
    }
    
    func tracingLocationDidFailWithError(error: Error) {
        LocationUtil.sharedInstance.currentLocation = CLLocation.init(latitude: 0, longitude: 0)
    }
}
