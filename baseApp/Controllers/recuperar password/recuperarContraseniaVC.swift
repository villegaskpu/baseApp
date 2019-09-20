//
//  recuperarContraseniaVC.swift
//  baseApp
//
//  Created by David on 9/13/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class recuperarContraseniaVC: BViewController {
    
    @IBOutlet weak var ltituloRecuperarPass: UILabel!
    @IBOutlet weak var lingresaTuCorreo: UILabel!
    @IBOutlet weak var lCorreoElectronico: UILabel!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var constrainHImage: NSLayoutConstraint!
    
    @IBOutlet weak var constraintWBtnEnviar: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        if Device.iPhone5 {
            constrainHImage.constant = 60
            constraintWBtnEnviar.constant = 200
        }
    }
    
    private func setStyle() {
        lingresaTuCorreo.adjustsFontSizeToFitWidth = true
        lingresaTuCorreo.minimumScaleFactor = 0.3
        ltituloRecuperarPass.font = UIFont.titulosModales
        ltituloRecuperarPass.textColor = UIColor.battleshipGrey
        
        lingresaTuCorreo.font = UIFont.textPurple
        lingresaTuCorreo.textColor = UIColor.colorBrownGrey
        
        lCorreoElectronico.font = UIFont.labelWhite
        lCorreoElectronico.textColor = UIColor.black
    }
    
    
    func sendPassword() {
        
        if txtCorreo.text == ""
        {
            Commons.showMessage("Ingresa un correo electrónico para recuperar tu password")
        }
        else if !Commons.isValidEmail(txtCorreo.text!){
            Commons.showMessage("Ingresa un correo electrónico valido")
        }
        else
        {

            let requestForgotPassword = Requests.createForgotPasswordRequest(txtCorreo.text ?? "")
            
            let network = Network()
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setConstants(constants: constantsParameters)
            network.setUrlParameters(urlParameters: requestForgotPassword)
            network.endPointN(endPont: .ForgotPassword) { (statusCode, value, objeto) -> (Void) in
                if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                    Commons.showMessage("SUCCESS_RECOVER_PASSWORD".localized + (self.txtCorreo.text!),duration: .long)
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        self.dismiss(animated: true, completion: nil)
                    })
                } else {
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
            }
        }
    }
    
    func isValidEmail(test: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: test)
    }
    
    
    @IBAction func btnEnviarAction(_ sender: Any) {
        sendPassword()
    }
    
    
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
