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

class LoginVC: BViewController {
    
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var viewTextFiels: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var iconEye: UIButton!
    @IBOutlet weak var txtCorreo: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var recuperarContraseña: UIButton!
    @IBOutlet weak var ingresoAnonimo: UIButton!
    @IBOutlet weak var crearCuenta: UIButton!
    
    var showPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        animateView(viewA: homeLogo, point: CGPoint(x: homeLogo.center.x - 150, y: homeLogo.center.y))
        animateView(viewA: viewTextFiels, point: CGPoint(x: viewTextFiels.center.x , y: viewTextFiels.center.y - 300))
        animateButtonLogin()
        
        
        addsTargets()
    }
    
    func addsTargets() {
        txtCorreo.tag = 1
        txtPassword.tag = 2
        txtCorreo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        iconEye.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 1.3) {
                self.btnLogin.alpha = 1
                self.iconEye.alpha = 1
            }
        }
    }
    
    
    
    @IBAction func btnShowPassword(_ sender: Any) {
        if showPassword { // es visible
            print("visible")
            iconEye.setImage(UIImage(named: "IconEye") , for: .normal)
            txtPassword.isSecureTextEntry = true
            showPassword = false
        } else { // esta oculto
            print("oculto")
            iconEye.setImage(UIImage(named: "IconEyeOff") , for: .normal)
            showPassword = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
    
    
    @IBAction func btnEntrar(_ sender: Any) {
        showLoading()
        self.view.endEditing(true)
        if validateForm() {
//            if Network.Login(correo: txtCorreo.text!, password: txtPassword.text!) {
//                print("estamos dentro")
//            } else {
//                print("entro en el else")
//            }

            let network = Network()
            network.setUrlParameters(urlParameters: Requests.createLoginRequest(txtCorreo.text!, txtPassword.text!, userAgent: Commons.getUserAgent()))


            network.endPointN(endPont: .Login) { (statusCode, value, error) -> (Void) in
                
                if statusCode >= 200 && statusCode < 300 {
                    print("ya estufas: \(value)")
                }else {
                    print("valio pistola: \(value)")
                    Commons.showMessage(StatusCode.strStatusCode(endPoint: .Login, StatusCode: statusCode))
                }
                self.hideLoading()
            }
        } else {
            self.hideLoading()
        }
    }
    
    
    // MARK: VALIDATE FORM
    
    func validateForm() -> Bool
    {
        if self.txtCorreo.text == nil || self.txtCorreo.text == "" {
            return false
        }
        else if self.txtPassword.text == nil || self.txtPassword.text == "" {
            return false
        }
        else if (self.txtPassword.text?.count)! < 6 {
            return false
        }
        return true
    }
    
    // MARK: Target de textFiels
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if textfield.tag == 1 {
            if !Commons.isValidEmail(textfield.text ?? "") {
                txtCorreo.errorMessage = "INVALID_EMAIL".localized
            }
            else {
                txtCorreo.errorMessage = ""
            }
        }
        else if textfield.tag == 2 {
            if (self.txtPassword.text?.count)! < 6 {
                txtPassword.errorMessage = "MISSING_INFO".localized
            }
            else {
                txtPassword.errorMessage = ""
            }
        }
    }
}
