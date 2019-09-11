//
//  TerminosYCondicionesVC.swift
//  baseApp
//
//  Created by David on 9/2/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

class TerminosYCondicionesVC: BViewController {
    
    @IBOutlet weak var lTitulo: UILabel!
    @IBOutlet weak var lTerminosText: UITextView!
    @IBOutlet weak var btnCloseO: UIButton!
    
    @IBOutlet weak var viewContent: UIView!
    var strTerminos = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0.6718506217, green: 0.7186080813, blue: 0.7945843339, alpha: 1)
        viewContent.backgroundColor = #colorLiteral(red: 0.8671034575, green: 0.8866966367, blue: 0.9186367393, alpha: 1)
        viewContent.layer.cornerRadius = 10
        viewContent.layer.borderColor = UIColor.white.cgColor
        viewContent.layer.borderWidth = 2.0
        
        btnCloseO.setImage(#imageLiteral(resourceName: "green_close"), for: UIControl.State.normal)
        
        lTitulo.font = UIFont.titulosModales
        lTerminosText.textColor = UIColor.colorBrownGrey
        lTerminosText.font = UIFont.textJustGeneral
    }
    
    @IBAction func btnCloseA(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
}
