//
//  ofertaReportadaVC.swift
//  baseApp
//
//  Created by David on 9/12/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

class ofertaReportadaVC: BViewController {

    
    @IBOutlet weak var imgCarita: UIImageView!
    @IBOutlet weak var lLamentamosLoSucedido: UILabel!
    @IBOutlet weak var lGraciasComentarios: UILabel!
    @IBOutlet weak var lDesdeEsteMemento: UILabel!
    
    @IBOutlet weak var contenViewL: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCarita.image = UIImage(named: "Icon_Lamentamos")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgCarita.tintColor = UIColor.white
        setStyles()
    }
    
    private func setStyles() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        self.view.backgroundColor = UIColor.lightGreyBlue
        
        contenViewL.layer.cornerRadius = 10.0
        
        imgCarita.tintColor = UIColor.white
        lLamentamosLoSucedido.font = UIFont.btnReportarOferta
        lGraciasComentarios.font = UIFont.colorTextMenu
        lDesdeEsteMemento.font = UIFont.textDescription
        
    }
    
    @IBAction func btnCerrar(_ sender: Any) {
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
