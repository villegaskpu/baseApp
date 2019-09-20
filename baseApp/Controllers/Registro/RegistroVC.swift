//
//  RegistroVC.swift
//  baseApp
//
//  Created by David on 8/29/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import Foundation
import a4SysCoreIOS
import CoreLocation

enum campos:String {
    case empresa = "empresa"
    case noEmpleado = "noEmpleado"
    case genero = "genero"
    case fechaNacimiento = "fechaDeNacimiento"
    case correoElectronico = "correoElectronico"
    case confirmaCorreoElectronico = "confirmaCorreoElectronico"
    case contrasenia = "contrasenia"
    case confirmaContrasenia = "confirmaContrasenia"
    case aviso = "aviso"
    case stack = "stack"
    
}

class RegistroVC: BTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        BaseDelegate = self
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .textField, .label, .button, .stack, .pickerView, .datePicker, .calendarCell)
        
        tableItems.removeAll()
        initData()
        setupNavBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = setTitleview()
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), landscapeImagePhone: #imageLiteral(resourceName: "backArrow"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtn))
        menuButton.tintColor = #colorLiteral(red: 0.7780508399, green: 0.8403770328, blue: 0.9060906768, alpha: 1)
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func backBtn() {
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func initData() {
        let empresa = InfoItem.init(identifier: campos.empresa.rawValue, type: InfoItemType.calendarCell, title: "Empresa", value: "")
        empresa.typePikerView = .pikerView
        empresa.required = true
        empresa.showItem = false
        
        let noEmpleado = InfoItem.init(identifier: campos.noEmpleado.rawValue, type: InfoItemType.textField, title: "No. Epleado", value: "")
        
        let genero = InfoItem.init(identifier: campos.genero.rawValue, type: InfoItemType.calendarCell, title: "Género", value: "")
        genero.tupleArray = [("G","Género"),("F", "Femenino"), ("M","Masculino")]
        genero.typePikerView = .pikerView
        genero.showItem = false
        genero.required = false
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = Date()
        
        let strDate = "\(date.currentDay(true))-\(date.currentMonth(true))-\(date.currentYear())"
        
        let pickerFecha = InfoItem(identifier: campos.fechaNacimiento.rawValue, type: .calendarCell, title: "Fecha de nacimiento", value: strDate)
        pickerFecha.typePicker = .date
        pickerFecha.typePikerView = .datePiker
        
        
        let correo = InfoItem.init(identifier: campos.correoElectronico.rawValue, type: InfoItemType.textField, title: "Correo Electrónico", value: "")
        let confirmaCorreo = InfoItem.init(identifier: campos.confirmaCorreoElectronico.rawValue, type: InfoItemType.textField, title: "Confirmar correo", value: "")
        
        let contrasenia = InfoItem.init(identifier: campos.contrasenia.rawValue, type: InfoItemType.textField, title: "Contraseña", value: "")
        let confirmaContrasenia = InfoItem.init(identifier: campos.confirmaContrasenia.rawValue, type: InfoItemType.textField, title: "Confirmar Contraseña", value: "")
        
        let aviso = InfoItem.init(identifier: campos.aviso.rawValue, type: InfoItemType.label, title: "", value: "Al hacer clic en Crear cuenta, aceptas los Términos y Condiciones y nuestro Aviso de Privacidad")
        aviso.textAlignmentL = .center
        
        
        let attributedString = NSMutableAttributedString(string: "Al dar clic en “Crear cuenta” estás\naceptando los terminos, condiciones\ny aviso de privacidad.", attributes: [
            .font: UIFont(name: "Roboto-Light", size: 15.0)!,
            .foregroundColor: UIColor(white: 128.0 / 255.0, alpha: 1.0),
            .kern: 0.0
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Medium", size: 15.0)!, range: NSRange(location: 16, length: 13))
        
        aviso.attributedString = attributedString
        
        let stack = InfoItem.init(identifier: campos.stack.rawValue, type: InfoItemType.stack, title: "Recuperar contraseña", value: "Iniciar sesión", itemHeight: 40.0)
        
        let guardar = InfoItem(identifier: "guardar", type: .button, title: "Crear cuenta", value: "BG_Bottom")
        guardar.image = UIImage(named: "BG_Bottom")
        
        
        
        tableItems.set(section: "", identifier: "captura")
        tableItems.append(item: noEmpleado)
        tableItems.append(item: pickerFecha)
        tableItems.append(item: empresa)
        tableItems.append(item: genero)
        tableItems.append(item: correo)
        tableItems.append(item: confirmaCorreo)
        tableItems.append(item: contrasenia)
        tableItems.append(item: confirmaContrasenia)
        tableItems.append(item: aviso)
        tableItems.append(item: guardar)
        tableItems.append(item: stack)
        
        tableView.reloadData()
    }
    
    private func getCommpany(_ idEmpleado:String, FechaDeNacimiento:String) {
        let request =  [
            "idEmployee" : "\(idEmpleado)",
            "birthday":"\(FechaDeNacimiento)"
        ]
        
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: request)
        
        network.endPointN(endPont: .GetCompanies) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let companys = objeto as? [Company] {
                    if companys.count > 1 {
                        var empresas:[(String, String)] = []
                        for a in companys {
                            empresas.append(("\(a.idCompany)", a.name))
                        }
                        self.tableItems.getItem(identifier: campos.empresa.rawValue)?.tupleArray = empresas
                        self.tableItems.getItem(identifier: campos.empresa.rawValue)?.showItem = true
                        self.tableView.reloadData()
                    } else {
                        if companys.count > 0 {
                            self.tableItems.getItem(identifier: campos.empresa.rawValue)?.value = companys[0].name
                            self.tableItems.getItem(identifier: campos.empresa.rawValue)?.valueId = "\(companys[0].idCompany)"
                            var empresas:[(String, String)] = []
                            for a in companys {
                                empresas.append(("\(a.idCompany)", a.name))
                            }
                            self.tableItems.getItem(identifier: campos.empresa.rawValue)?.tupleArray = empresas
                            self.tableItems.getItem(identifier: campos.empresa.rawValue)?.showItem = true
                        }
                    }
                }
            } else {
                print("falloValid")
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


//MARK: TABLEVIEW DELEGATE & DATASOURCE
extension RegistroVC {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 60.0 : 0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableItems.getItemIdentifier(section: indexPath.section, at: indexPath.row) == campos.stack.rawValue {
            let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "celdaStack3") as! celdaStack3
            cell.btnUno.setTitle(item.title, for: UIControl.State.normal)
            cell.btnDos.setTitle(item.value, for: UIControl.State.normal)
            cell.delegate = self
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableItems.getItem(section: indexPath.section, at: indexPath.row).identifier == campos.aviso.rawValue {
            let vc = TerminosYCondicionesVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension RegistroVC : BTableViewDelegate , celdaStack3Delegate{
    
    
    func BTableView(tableItems: InfoManager, textFieldDidChange text: String, indexPath: IndexPath) {
        
        self.tableItems.getItem(section: indexPath.section, at: indexPath.row).value = text
//        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
        if tableItems.getItem(section: indexPath.section, at: indexPath.row).identifier == campos.fechaNacimiento.rawValue {
            print("seleccionado la fechadel empleado")
            
            let noEmpleado = tableItems.getItem(identifier: campos.noEmpleado.rawValue)?.value ?? ""
            
            self.getCommpany(noEmpleado, FechaDeNacimiento: tableItems.getItem(section: indexPath.section, at: indexPath.row).value)
        }
        else if tableItems.getItem(section: indexPath.section, at: indexPath.row).identifier == campos.noEmpleado.rawValue {
            let noEmpleado = tableItems.getItem(identifier: campos.noEmpleado.rawValue)?.value ?? ""
            self.getGenero(noEmpleado)
        }
    }
    
    func BTableView(tableItems: InfoManager, buttonPressedAt indexPath: IndexPath) {
        print("presiono guardar")
        
        if tableItems.isReadyToSave() {
            print("todo chido")
            if validateForm() {
                print("todo chido2")
                crearCuenta()
            }
        } else {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            tableView.reloadData()
        }
        
    }
    
    func validateForm() -> Bool
    {
        let tamCon = tableItems.getItem(identifier: campos.contrasenia.rawValue)?.value.count ?? 0
        let tamCon2 = tableItems.getItem(identifier: campos.confirmaContrasenia.rawValue)?.value.count ?? 0
        
        let con = tableItems.getItem(identifier: campos.contrasenia.rawValue)?.value
        let con2 = tableItems.getItem(identifier: campos.confirmaContrasenia.rawValue)?.value
        
        if tableItems.getItem(identifier: campos.correoElectronico.rawValue)?.value == "" {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            return false
        }
        else if tableItems.getItem(identifier: campos.noEmpleado.rawValue)?.value == ""
        {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            return false
        }
        
        else if tableItems.getItem(identifier: campos.fechaNacimiento.rawValue)?.value == ""
        {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            return false
        }
        else if tableItems.getItem(identifier: campos.contrasenia.rawValue)?.value == ""
        {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            return false
        }
        else if tableItems.getItem(identifier: campos.confirmaContrasenia.rawValue)?.value == ""
        {
            Commons.showMessage("Los campos marcados con (*) son obligatorios")
            return false
        }
        else if tamCon < 6 || tamCon2 < 6
        {
            Commons.showMessage("MISSING_INFO".localized)
            return false
        }
        else if !Commons.isValidEmail(tableItems.getItem(identifier: campos.correoElectronico.rawValue)?.value ?? "")  || !Commons.isValidEmail(tableItems.getItem(identifier: campos.confirmaCorreoElectronico.rawValue)?.value ?? ""){
            Commons.showMessage("INVALID_EMAIL".localized)
            return false
        }
        else if let a = con?.lowercased().trimmingCharacters(in: NSCharacterSet.whitespaces), let b =  con2?.lowercased().trimmingCharacters(in: NSCharacterSet.whitespaces)
        {
            if a != b {
                Commons.showMessage("Los correos electrónicos no coinciden")
                return false
            }
        }
        if con != con
        {
            Commons.showMessage("MISSING_DIFFERENT_PASSWORD".localized)
            return false
        }
        
        return true
    }
    
    
    
    func selectBtn(value: Int) {
        print("valuesSelected: \(value)")
        if value == 1 {
            let vc = recuperarContraseniaVC()
            self.navigationController?.fadeTo(vc)
        } else {
            let vc = LoginVC()
            self.navigationController?.fadeTo(vc)
        }
    }
    
    private func getGenero(_ idEmpleado:String) {
        
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: [:])
        network.setIdEmpleado(idEmpleado: idEmpleado)
        
        network.endPointN(endPont: .ValidateGender) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let genero = objeto as? Customer {
                    if genero.gender == "" {
                        self.tableItems.getItem(identifier: campos.genero.rawValue)?.showItem = true
                    } else {
                        self.tableItems.getItem(identifier: campos.genero.rawValue)?.showItem = false
                    }
                } else {
                    print("fallo parser")
                }
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
    
    
    private func crearCuenta() {
        showLoading()
        var requestSignUp : [String : Any]
        let empleado = tableItems.getItem(identifier: campos.noEmpleado.rawValue)?.value ?? ""
        let fecha = tableItems.getItem(identifier: campos.fechaNacimiento.rawValue)?.value ?? ""
        
        let genero = tableItems.getItem(identifier: campos.genero.rawValue)?.value == "Masculino" ? "M" : (tableItems.getItem(identifier: campos.genero.rawValue)?.value == "Femenino" ? "F" : "")
        let correo = tableItems.getItem(identifier: campos.correoElectronico.rawValue)?.value.lowercased().trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
        let pass = tableItems.getItem(identifier: campos.contrasenia.rawValue)?.value ?? ""
        
    
        let em = tableItems.getItem(identifier: campos.empresa.rawValue)?.tupleArray
        let val = tableItems.getItem(identifier: campos.empresa.rawValue)?.value ?? ""
        
        let emm = em?.filter({$0.1 == val}).first?.0.toInt() ?? 0
        
        let latitude = LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0
        let longitude = LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0
        
        requestSignUp = Requests.createSignUpRequest(empleado.trimmingCharacters(in: CharacterSet.whitespaces), fecha.trimmingCharacters(in: CharacterSet.whitespaces), genero, correo, pass.trimmingCharacters(in: CharacterSet.whitespaces), "\(latitude)", "\(longitude)", emm)
        
        
        
        
        
        let network = Network()
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setConstants(constants: constantsParameters)
        network.setUrlParameters(urlParameters: requestSignUp)
        network.endPointN(endPont: .Register) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                
                if let obj = objeto as? SignUpResponse { // no se forsa el cast para evitar que truene el app
                    print("SetValues")
                    DispatchQueue.main.async {
                        Settings.sharedInstance.setSesion(true)
                        Settings.sharedInstance.setUsername(value: correo)
                        Settings.sharedInstance.setPassword(value: pass)
                        Settings.sharedInstance.setToken(value: obj.token ?? "")
                        Settings.sharedInstance.setOldToken(value: obj.tokenYopter ?? "")
                        Settings.sharedInstance.setAnonymous(value: "false")
                        
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
            self.hideLoading()
        }
        
        
    }
    
    
    
//    func BTableView(tableItems: InfoManager, dateSelected indexPath: IndexPath) {
//
//    }
}

