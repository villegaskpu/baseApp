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
        
        viewContent.backgroundColor = #colorLiteral(red: 0.4446854591, green: 0.222956419, blue: 0.3612287641, alpha: 1)
        
        btnCloseO.setImage(#imageLiteral(resourceName: "green_close"), for: UIControl.State.normal)
        
        lTitulo.font = UIFont(name: Font.FONT_BOLD(), size: 17)
        lTerminosText.textColor = #colorLiteral(red: 0.9937927127, green: 0.5748035312, blue: 0.0008185596671, alpha: 1)
        lTerminosText.font = UIFont(name: Font.FONT_REGULAR(), size: 14.0)
    }
    
    
    @IBAction func btnCloseA(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
