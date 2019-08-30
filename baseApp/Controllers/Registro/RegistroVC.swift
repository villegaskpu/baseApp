//
//  RegistroVC.swift
//  baseApp
//
//  Created by David on 8/29/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import Foundation

enum campos:String {
    case empresa = "empresa"
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
    
    let imageView = UIImageView()
    let btnCerrar = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        BaseDelegate = self
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .textField, .label, .button, .stack)
        
        tableItems.removeAll()
        setParalax()
        initData()
    }
    
    func setParalax() {
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        imageView.image = UIImage.init(named: "HomeLogoR")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        btnCerrar.frame = CGRect(x: UIScreen.main.bounds.size.width - 30, y: 30, width: 20, height: 20)
        btnCerrar.setImage(#imageLiteral(resourceName: "black_close"), for: UIControl.State.normal)
        btnCerrar.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnCerrar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnCerrar.titleLabel?.font = UIFont(name: Font.FONT_BOLD(), size: 18.0)
        btnCerrar.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
        view.addSubview(btnCerrar)
        view.addSubview(imageView)
        
    }
    
    @objc func close() {
        print("close")
        self.navigationController?.popViewController(animated: true)
    }
    
    func initData() {
        let empresa = InfoItem.init(identifier: campos.empresa.rawValue, type: InfoItemType.textField, title: "Empresa", value: "")
        empresa.required = true
        
        let noEmpleado = InfoItem.init(identifier: campos.empresa.rawValue, type: InfoItemType.textField, title: "No. Epleado", value: "")
        
        let fechaDeNecimiento = InfoItem.init(identifier: campos.fechaNacimiento.rawValue, type: InfoItemType.textField, title: "Fecha de necimiento", value: "")
        
        let correo = InfoItem.init(identifier: campos.fechaNacimiento.rawValue, type: InfoItemType.textField, title: "Correo Electrónico", value: "")
        let confirmaCorreo = InfoItem.init(identifier: campos.confirmaCorreoElectronico.rawValue, type: InfoItemType.textField, title: "Confirmar correo", value: "")
        
        let contrasenia = InfoItem.init(identifier: campos.fechaNacimiento.rawValue, type: InfoItemType.textField, title: "Contraseña", value: "")
        let confirmaContrasenia = InfoItem.init(identifier: campos.fechaNacimiento.rawValue, type: InfoItemType.textField, title: "Confirmar Contraseña", value: "")
        
        let aviso = InfoItem.init(identifier: campos.aviso.rawValue, type: InfoItemType.label, title: "", value: "Al hacer clic en Crear cuenta, aceptas los Términos y Condiciones y nuestro Aviso de Privacidad")
        aviso.textAlignmentL = .center
        
        let stack = InfoItem.init(identifier: campos.stack.rawValue, type: InfoItemType.stack, title: "Ya tengo cuenta, iniciar sesión", value: "|  Contacto", itemHeight: 40.0)
        
        let guardar = InfoItem(identifier: "guardar", type: .button, title: "CREAR CUENTA", value: "")
        
        tableItems.set(section: "", identifier: "captura")
        tableItems.append(item: empresa)
        tableItems.append(item: noEmpleado)
        tableItems.append(item: fechaDeNecimiento)
        tableItems.append(item: correo)
        tableItems.append(item: confirmaCorreo)
        tableItems.append(item: contrasenia)
        tableItems.append(item: confirmaContrasenia)
        tableItems.append(item: aviso)
        tableItems.append(item: guardar)
        tableItems.append(item: stack)
        
        tableView.reloadData()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 0 - (scrollView.contentOffset.y + 0)
        let height = min(max(y, 0), 200)
        let heightImage = min(max(y, 0), 20)
        btnCerrar.frame = CGRect(x: UIScreen.main.bounds.size.width - 30, y: 30, width: 20, height: heightImage)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
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
}

extension RegistroVC : BTableViewDelegate , celdaStack3Delegate{
    func BTableView(tableItems: InfoManager, buttonPressedAt indexPath: IndexPath) {
        print("presiono guardar")
        
        if tableItems.isReadyToSave() {
            print("todo chido")
        } else {
            Commons.showMessage("Haven falta campos obligatorios")
        }
    }
    
    func selectBtn(value: Int) {
        print("valuesSelected: \(value)")
    }
}

