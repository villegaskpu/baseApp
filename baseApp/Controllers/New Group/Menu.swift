//
//  menu.swift
//  SeekOp
//
//  Created by DESARROLLOSICOP on 23/07/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

protocol MenuDelegate {
    func selectedItem(idMenu: String, titulo: String)
}

class Menu2: BTableViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constraintView: NSLayoutConstraint!
    
    
    @IBOutlet weak var lterminosYCondiciones: UILabel!
    
    @IBOutlet weak var txtFormato: UILabel!
    
    
    
    
    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = #colorLiteral(red: 0.6720844507, green: 0.7303457856, blue: 0.8063297868, alpha: 1)
        
        container.shadow()
        
        TableViewCellFactory.registerCells(tableView: tableView, identifiers: "InfoSession", "MenuOption")
        
        version.font = UIFont.linkWhite
        version.textColor = .darkGray
        version.adjustsFontSizeToFitWidth = true
        version.minimumScaleFactor = 0.3
        
        self.version.text = Commons.version()
        
        if tableItems.numberOfSections() > 0 {
            indicator.stopAnimating()
        }
        
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(irAterminosYcondiciones))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        
    lterminosYCondiciones.addGestureRecognizer(mytapGestureRecognizer)
        
        
        setTerminos()
    }
    
    @objc func irAterminosYcondiciones() {
        delegate?.selectedItem(idMenu: "terminos", titulo: "")
    }
    
    private func setTerminos() {
        
        let text = "Términos, condiciones y aviso de privacidad"
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont(name: "Avenir-Medium", size: 12.0)!,
            .foregroundColor: UIColor.darkHotPink
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "Roboto-Medium", size: 12.0)!, range: NSRange(location: 30, length: 2))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0 , length: text.count))
        
        lterminosYCondiciones.attributedText = attributedString
        lterminosYCondiciones.minimumScaleFactor = 0.3
        lterminosYCondiciones.adjustsFontSizeToFitWidth = true
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observer.menuIconPressed), object: nil)
    }
}

//MARK: SOInitAppDelegate METHODS
extension Menu2: SOInitAppDelegate {
    
    func updateMenu(menuItems: InfoManager) {
        tableItems = menuItems
        tableView.reloadData()
        indicator.stopAnimating()
    }
    
    
}

extension Menu2 {
    
}

//MARK: TABLEVIEW METHODS
extension Menu2 {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOption") as! MenuOption
                cell.titulo.text = item.title
                cell.imagen.image = item.image
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableItems.getItem(section: indexPath.section, at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !item.identifier.elementsEqual("info") {
            dismiss(animated: true) {
                self.delegate?.selectedItem(idMenu: item.identifier, titulo: item.title)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observer.menuIconPressed), object: nil)
        }
    }
}
