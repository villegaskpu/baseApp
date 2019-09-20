//
//  detalleOfertaVC.swift
//  baseApp
//
//  Created by David on 9/10/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS
import ImageSlideshow
import Alamofire

class detalleOfertaVC: BViewController {
    

    @IBOutlet weak var sliderImage: ImageSlideshow!
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var titleOffert: UILabel!

    
    @IBOutlet weak var fechaL: UILabel!
    @IBOutlet weak var secondTitleL: UILabel!
    @IBOutlet weak var detalleL: UILabel!
    @IBOutlet weak var detalleDescripcionL: UILabel!
    @IBOutlet weak var condicionesL: UILabel!
    @IBOutlet weak var descripcionCondicionesL: UILabel!
    
    @IBOutlet weak var promocionAplicableTitleL: UILabel!
    @IBOutlet weak var sucursalesTextView: UITextView!
    
    
    @IBOutlet weak var btnreportarOfertaO: UIButton!
    @IBOutlet weak var contentViewSucursales: UIView!
    
    var offerTakenResponse: OfferTakenResponse?
    
    var tiendas = ""
    
    
    var offertSelect:Offer?
    
    var storesArray : [Store] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setupNavBar()
        setImagesSlider()
        setTextinViews()
        setStores()
    }
    
    private func setStyle() {
        titleOffert.font = UIFont.textStyle
        titleOffert.textColor = UIColor.white
        
        fechaL.font = UIFont.textStyle2
        fechaL.textColor = UIColor.brownishOrange
        
        secondTitleL.font = UIFont.tituloDetalleOferta
        secondTitleL.textColor = UIColor.battleshipGrey
        
        detalleL.font = UIFont.textOfertaCategory
        detalleL.textColor = UIColor.lightBlueGrey
        
        detalleDescripcionL.font = UIFont.textOfertaParrafo
        detalleDescripcionL.textColor = UIColor.warmGrey
        detalleDescripcionL.textAlignment = .justified
        
        condicionesL.font = UIFont.textOfertaCategory
        condicionesL.textColor = UIColor.lightBlueGrey
        condicionesL.textAlignment = .justified
        
        descripcionCondicionesL.font = UIFont.textOfertaParrafo
        descripcionCondicionesL.textColor = UIColor.warmGrey
        descripcionCondicionesL.textAlignment = .justified
        
        promocionAplicableTitleL.font = UIFont.textOfertaCategory
        promocionAplicableTitleL.textColor = UIColor.lightBlueGrey
        
        sucursalesTextView.font = UIFont.textOfertaParrafo
        sucursalesTextView.textColor = UIColor.warmGrey
        
        
//        contentViewSucursales.layer.borderColor = UIColor.warmGrey.cgColor
//        contentViewSucursales.layer.borderWidth = 1.0
        
        contentViewSucursales.shadow()
    }
    
    
    private func setImagesSlider() {
        
        if let offertImage = offertSelect {
            
            let commerceLogo = offertImage.commerce.s3LogoURL != "" ? offertImage.commerce.s3LogoURL : offertImage.commerce.logoURL
            
            self.secondImage.sd_setImage(with: (URL(string:(commerceLogo.replacingOccurrences(of: "{1}", with: "100").replacingOccurrences(of: "{2}", with: "full")))), placeholderImage: nil)
            
            if offertImage.images.count > 0 {
                var imageArray : [AlamofireSource] = []
                for image in offertImage.images {
                    let imageOffert = image.s3URL
                    
                    _ = imageOffert != "" ? imageArray.append(AlamofireSource.init(urlString: (imageOffert.replacingOccurrences(of: "{1}", with: "full").replacingOccurrences(of: "{2}", with: "full")))!) : imageArray.append(AlamofireSource.init(urlString: image.imageURL)!)
                }
                self.sliderImage.setImageInputs(imageArray)
                self.sliderImage.contentScaleMode = .scaleToFill
                self.sliderImage.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
                self.sliderImage.slideshowInterval = 3
                
            }
        }
    }
    
    private func setStores() {
        if let offert = self.offertSelect {
            var tiendas = ""
            for item in offert.commerce.stores {
//                self.storesArray.append(item)
                
                tiendas += "\n - \(item.name)"
            }
            
            
            self.sucursalesTextView.text = tiendas
            
        }
    }
    
    private func setTextinViews() {
        if let offert = self.offertSelect {
            titleOffert.text = offert.commerce.name.capitalized
            fechaL.text = "VÁLIDO HASTA: \(offert.endDate)"
            
            secondTitleL.text = offert.offerDescription
            
            detalleDescripcionL.text = offert.offerDescription
            
            descripcionCondicionesL.text = offert.conditions
            
        }
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
    
    
    @IBAction func btnTomarOferta(_ sender: Any) {
        
        showLoading()
        let requestTakeOffer = Requests.createTakeOfferRequest(LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
        
        let network = Network()
        
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setConstants(constants: constantsParameters)
        network.setUrlParameters(urlParameters: requestTakeOffer)
        network.setIdOffert(idOfert: "\(offertSelect?.idOffer ?? 0)")
        
        network.endPointN(endPont: .OfferTaken) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let token = objeto as? OfferTakenResponse {
                    self.offerTakenResponse = token
                    
                    
                    let vc = TomarOfertaVC()
                    vc.offerTakenResponse = self.offerTakenResponse
                    vc.ofertResive = self.offertSelect
                    self.navigationController?.fadeTo(vc)
                    
                    let request = Requests.createFavoriteOfferRequest((self.offertSelect?.idOffer ?? 0), 1, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
                    
        
                    let network2 = Network()
                    
                    network2.setEnvironment(Environment: ENVIROMENTAPP)
                    network2.setConstants(constants: constantsParameters)
                    network2.setUrlParameters(urlParameters: request)
                    network2.setIdOffert(idOfert: "\(self.offertSelect?.idOffer ?? 0)")
                    
                    network2.endPointN(endPont: .OfferFavorite, { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                            print("Favorite sucess")
                        }
                    })
                    
                    self.hideLoading()
                } else {
                    self.hideLoading()
                }
                
            } else {
                self.hideLoading()
            }
        }
    }
    
    
    @IBAction func btnReportarOfertaAtion(_ sender: Any) {
        let vc = reportarOfertaVC()
        vc.offertSelec = self.offertSelect
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
