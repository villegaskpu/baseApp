//
//  TomarOfertaVC.swift
//  baseApp
//
//  Created by David on 9/11/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class TomarOfertaVC: BViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lTituloHasTomadoO: UILabel!
    @IBOutlet weak var lDescripcionDeOferta: UILabel!
    @IBOutlet weak var lTituloConelCodigo: UILabel!
    @IBOutlet weak var lCodigoOferta: UILabel!
    @IBOutlet weak var imagenCodigo: UIImageView!
    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var contraintHImahe: NSLayoutConstraint!
    @IBOutlet weak var constraintWImage: NSLayoutConstraint!
    
    
    @IBOutlet weak var constraintHViewScoll: NSLayoutConstraint!
    
    var offerTakenResponse : OfferTakenResponse?
    var ofertResive:Offer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStile()
        setData()
        setupNavBar()
    }
    
    
    private func setStile() {
        lTituloHasTomadoO.textColor = UIColor.darkHotPink
        lTituloHasTomadoO.font = UIFont.titulosPink
        lTituloHasTomadoO.adjustsFontSizeToFitWidth = true
        lTituloHasTomadoO.minimumScaleFactor = 0.3
        
        
        
        lDescripcionDeOferta.textColor = UIColor.lightGray
        lDescripcionDeOferta.font = UIFont.textDescription
        
        lTituloConelCodigo.textColor = UIColor.black
        lTituloConelCodigo.font = UIFont.textDescription
        
        lCodigoOferta.textColor = UIColor.darkHotPink
        lCodigoOferta.font = UIFont.titulos
        lCodigoOferta.numberOfLines = 0
        lCodigoOferta.adjustsFontSizeToFitWidth = true
        lCodigoOferta.minimumScaleFactor = 0.3
        
        
    }
    
    private func setData() {
        guard let ofert = self.ofertResive else {return}
        guard let offerTaken = offerTakenResponse else {return}
        lDescripcionDeOferta.text = ofert.offerDescription
        
        
        lCodigoOferta.text = offerTaken.takeCode
        
        let code = offerTaken.takeCodeType?.idTakeCodeType
        
        switch code {
        case 2,5:
            imagenCodigo.image = Commons.generateCode128(code: "\(String(describing: offerTaken.takeCode))")
            if Device.iPhone5 {
                constraintWImage.constant = Screen.width - 10
            }
        case 1,3,7:
            imagenCodigo.image = Commons.generateCodeQR(code: "\(offerTaken.takeCode ?? "")")
            if Device.iPhone5 {
                contraintHImahe.constant = 200
                constraintWImage.constant = 200
            } else {
                contraintHImahe.constant = 300
                constraintWImage.constant = 300
                constraintHViewScoll.constant = 800
            }
        default:
            imagenCodigo.image = nil
            if offerTaken.takeCode == nil || offerTaken.takeCode == ""
            {
//                self.withCode.isHidden = true
            }
        }
        
        
        
        let commerceLogo = ofert.commerce.s3LogoURL != "" ? ofert.commerce.s3LogoURL :   ofert.commerce.logoURL != "" ? ofert.commerce.logoURL : ""
        
        _ = commerceLogo != "" ? (self.imageLogo.sd_setImage(with: URL(string: (commerceLogo.replacingOccurrences(of: "{1}", with: "100").replacingOccurrences(of: "{2}", with: "full"))), placeholderImage: nil)) : (self.imageLogo.image = nil)
        
        
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
        self.navigationController?.popViewController(animated: true)
    }
    
}
