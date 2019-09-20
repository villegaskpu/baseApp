//
//  menuLateralVC.swift
//  baseApp
//
//  Created by David on 9/18/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper
import a4SysCoreIOS
import MessageUI

class menuLateralVC: BTableViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var lTerminosYCondiciones: UILabel!
    @IBOutlet weak var txtFormato: UILabel!
    
    @IBOutlet weak var txtVersiom: UILabel!
    
    
    var items:[Menu] = []
    
    let opSalir:[String:Any] = [
        "action" :
            [
                "URL" : "",
                "type" : 99,
                "webView" : 0
        ],
        "iconURL" : "",
        "name" : "Salir",
        "order" : 5
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contenView.backgroundColor = #colorLiteral(red: 0.6720844507, green: 0.7303457856, blue: 0.8063297868, alpha: 1)
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = #colorLiteral(red: 0.6720844507, green: 0.7303457856, blue: 0.8063297868, alpha: 1)
        
        TableViewCellFactory.registerCells(tableView: tableView, identifiers: "InfoSession", "MenuOption")
        
        setMenu()
        setTerminos()
    }
    
    private func setTerminos() {
        
        let text = "Términos, condiciones y aviso de privacidad"
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont(name: "Avenir-Medium", size: 12.0)!,
            .foregroundColor: UIColor.darkHotPink
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Medium", size: 12.0)!, range: NSRange(location: 30, length: 2))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0 , length: text.count))
        
        lTerminosYCondiciones.attributedText = attributedString
        lTerminosYCondiciones.minimumScaleFactor = 0.3
        lTerminosYCondiciones.adjustsFontSizeToFitWidth = true
        
        
        //¿Conoces un comercio al que le interesaría ofrecer una promoción? Llena el formato
        
        //        txtFormato
        
        let stringAA = "¿Conoces un comercio al que le interesaría ofrecer una promoción? Llena el formato"
        
        let attributedString2 = NSMutableAttributedString(string: stringAA, attributes: [
            .font: UIFont.textMenuWhite,
            .foregroundColor: UIColor.white,
            .kern: -0.21
            ])
        attributedString2.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: stringAA.count - 16 , length: 16))
        txtFormato.attributedText = attributedString2
        
        
        txtVersiom.font = UIFont.linkWhite
        txtVersiom.textColor = UIColor.white
        
        txtVersiom.text = Commons.version()
        
    }
    
    func setMenu() {
        if Settings.sharedInstance.getThemeCustom() {
            if let opMenu = Settings.sharedInstance.getMenu() {
                //print("ops : \(opsss[indexPath.row].name)")
 
                let men = Mapper<Menu>().mapArray(JSONArray: opMenu)
                
                tableItems.set(section: "")
                
                for a in men {
                    let item = InfoItem(identifier: "\(a.action.type)", type: InfoItemType.default, title: a.name, value: a.name)
                    item.url = a.iconURL
                    item.urlWebView = a.action.URL
                    item.webView = "\(a.action.webView)"
                    self.tableItems.append(item: item)
                }
                
                addSalir()
                
            } else {
                tableItems.set(section: "menu")
                addSalir()
            }
        } else {
            tableItems.set(section: "menu")
            addSalir()
        }
    }
    
    private func addSalir() {
        let item = InfoItem(identifier: "99", type: InfoItemType.default, title: "SALIR", value: "SALIR")
        item.url = ""
        item.webView = ""
        self.tableItems.append(item: item)
        tableView.reloadData()
    }
    
//    private func setMenu() {
//        tableItems.set(section: "")
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
//        tableItems.append(item: articulos)
//        tableItems.append(item: ofertas)
//        tableItems.append(item: contacto)
//        tableItems.append(item: tutorial)
//        tableItems.append(item: salir)
//        tableView.reloadData()
//    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: TABLEVIEW METHODS
extension menuLateralVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOption") as! MenuOption
        cell.titulo.text = item.title
        
        if item.title == "SALIR" {
            cell.imagen.image = UIImage(named: "salir_icon")
        } else {
            cell.imagen.sd_setImage(with: URL.init(string: "\(item.url)"), placeholderImage: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if item.identifier == "4" {
            self.sendEmailvv()
        } else {
            self.navigationController?.navigationBar.isHidden = false
            Navigation.push(idMenu: item.identifier, target: self, titulo: "", item: item)
        }
        
    }
    
    func sendEmailvv() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.delegate = self as? UINavigationControllerDelegate
            mail.setToRecipients([Constants.emailContact])
            mail.setSubject(Constants.emailSubject)
            mail.setMessageBody("<br /><br /><br /><br /><br /><br /><br /><br /><br />\(Commons.getUserAgentForEmail())", isHTML: true)
            
            present(mail, animated: true)
        } else {
            Commons.showMessage("SEND_EMAIL_UNAVAILABLE".localized)
        }
    }
    
//    @objc(mailComposeController:didFinishWithResult:error:) func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//        controller.navigationController?.popViewController(animated: true)
//    }
}

