//
//  cellOffert.swift
//  baseApp
//
//  Created by David on 8/23/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import SDWebImage
import a4SysCoreIOS

protocol cellOffertDelegate {
    func updateCell(indexPath:IndexPath, value:String, action:String)
    func deleteCell(indexPath:IndexPath)
}

class cellOffert: UITableViewCell {
    
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var offertTitle: UILabel!
    
    @IBOutlet weak var lTituloOferta: UILabel!
    
    // botones
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var saveOrDeleteImage: UIImageView!
    
    // imagenes
    @IBOutlet weak var newIndicator: UIImageView!
    @IBOutlet weak var offertImage: UIImageView!
    
    @IBOutlet weak var viewContentImage: UIView!
    
    
    @IBOutlet weak var constraintLTitulo: NSLayoutConstraint!
    
    @IBOutlet weak var constraintWsaveorDelete: NSLayoutConstraint!
    
    var isOffert = true
    var indexPath:IndexPath?
    var delegate:cellOffertDelegate?
    
    var offer: Offer? {
        didSet {
            guard let off = offer else {return}
            companyName.text = off.commerce.name
            offertTitle.text = off.offerDescription
            setShadowImage()
            validDistanceOfert(off: off)
            setImageLogo(infoCell: off)
            setActions()
            setIconButtons()
            setStyle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newIndicator.isHidden = true
        setShadowImage()
    }
    
    override func prepareForReuse() {
        newIndicator.isHidden = true
        setStyle()
        setShadowImage()
    }
    
    private func setShadowImage() {
        offertImage.layer.cornerRadius = 5
        Funciones.addShadow(view: viewContentImage, shadowOpacity: 0.5, cornerRadius: 2.0, color:UIColor.black)
    }
    
    private func setStyle() {
        lTituloOferta.font = UIFont.textCategoryOferta
        lTituloOferta.textColor = UIColor.brownishOrange
        
        companyName.font = UIFont.titleOferta
        offertTitle.font = UIFont.textDescription
        offertTitle.textColor = UIColor.warmGrey
        
        
        let attributedString = NSAttributedString(string: self.offer?.offerDescription ?? "", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        offertTitle.attributedText = attributedString
    }
    
    
    
    private func setActions() {
        let likeTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(like(_:)))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(likeTapGesture)
        
        let dislikeTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dislike(_:)))
        dislikeImage.isUserInteractionEnabled = true
        dislikeImage.addGestureRecognizer(dislikeTapGesture)
        
        let saveOrDeleteTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(saveOrDelete(_:)))
        saveOrDeleteImage.isUserInteractionEnabled = true
        saveOrDeleteImage.addGestureRecognizer(saveOrDeleteTapGesture)
    }
    
    private func validDistanceOfert(off:Offer) {
        if let distance = off.commerce.stores.first?.distance {
            if distance > 50 {
                if let _ = off.commerce.stores.first?.city {
                    constraintLTitulo.constant = 0
                } else {
                    constraintLTitulo.constant = 0
                }
            } else {
                constraintLTitulo.constant = 0
            }
        } else {
            constraintLTitulo.constant = 0
        }

        if off.virtual > 0
        {
            lTituloOferta.text = "OFERTA WEB"
            constraintLTitulo.constant = 0
        }
    }
    
    func setImageLogo(infoCell:Offer) {
        var commerceLogo = infoCell.commerce.s3LogoURL != "" ? (infoCell.commerce.logoURL != "" ? infoCell.commerce.logoURL : nil) : nil
        var offerImageP = infoCell.images.first?.s3URL != "" ? (infoCell.images.first?.imageURL != "" ? infoCell.images.first?.imageURL : nil) : nil
        offerImageP = offerImageP ?? commerceLogo
        commerceLogo = offerImageP == commerceLogo ? nil : commerceLogo
        
        if offerImageP != nil {
            offertImage.sd_setImage(with: URL.init(string: (offerImageP?.replacingOccurrences(of: "{1}", with: "320").replacingOccurrences(of: "{2}", with: "full"))!), placeholderImage: nil)
        } else {
            offertImage.image = UIImage(named: "back_no")
        }
        
        if infoCell.isHome{ 
            if infoCell.viewed > 0 {
                newIndicator.isHidden = true
            } else {
                newIndicator.isHidden = false
            }
        }
        else{
            newIndicator.isHidden = true
        }
    }
    
    private func setIconButtons() {
        if let infoCell = offer {
            var puedeSerFevoriota = 0
            
            let userRating = Int((infoCell.userRating.rating))
            switch(userRating)
            {
            case 1:
                likeImage.image = UIImage(named: "like")
                dislikeImage.image = UIImage(named: "dislike_on")
                saveOrDeleteImage.isHidden = true
                constraintWsaveorDelete.constant = 0
            case 5:
                puedeSerFevoriota = 5
                likeImage.image = UIImage(named: "like_on")
                dislikeImage.image = UIImage(named: "dislike")
                saveOrDeleteImage.image = UIImage(named: "star_off")
                saveOrDeleteImage.isHidden = false
                constraintWsaveorDelete.constant = 30
            default:
                likeImage.image = UIImage(named: "like")
                dislikeImage.image = UIImage(named: "dislike")
                saveOrDeleteImage.isHidden = true
                constraintWsaveorDelete.constant = 0
            }

            
            if infoCell.favorite > 0 {
                saveOrDeleteImage.isHidden = false
                constraintWsaveorDelete.constant = 30
                saveOrDeleteImage.image = UIImage(named: "star")
            } else {
                if puedeSerFevoriota == 5 {
                    saveOrDeleteImage.isHidden = false
                    constraintWsaveorDelete.constant = 30
                } else {
                    constraintWsaveorDelete.constant = 0
                    saveOrDeleteImage.isHidden = true
                }
            }
            
            if infoCell.isFavorite {
                saveOrDeleteImage.image = UIImage(named: "Trash_off")
                likeImage.isHidden = true
                dislikeImage.isHidden = true
                saveOrDeleteImage.isHidden = false
                constraintWsaveorDelete.constant = 30
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func saveOrDelete(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("saveOrDelete")
        if (UIImage(named:"star_off")?.isEqual(self.saveOrDeleteImage.image!))!
        {
            guard let offertRecive = self.offer else {return}
            self.saveOrDeleteImage.image = UIImage(named:"star")
            let request = Requests.createFavoriteOfferRequest(offertRecive.idOffer, 1, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)

            
            if (offertRecive.isArticle) {
                let network = Network()
                network.setUrlParameters(urlParameters: request)
                network.setEnvironment(Environment: ENVIROMENTAPP)
                network.setConstants(constants: constantsParameters)
                network.endPointN(endPont: .ArticleFavorite) { (statusCode, value, objeto) -> (Void) in
                    let statusC = statusCode.toInt() ?? 0
                    
                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        if let index = self.indexPath {
                            print("delegate")
                            self.delegate?.updateCell(indexPath: index, value: "0", action: "favorite")
                        }
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            } else {
                let network = Network()
                network.setEnvironment(Environment: ENVIROMENTAPP)
                network.setConstants(constants: constantsParameters)
                network.setUrlParameters(urlParameters: request)
                let idOfert = offer?.idOffer ?? 0
                network.setIdOffert(idOfert: "\(idOfert)")
                network.endPointN(endPont: .OfferFavorite) { (statusCode, value, objeto) -> (Void) in
                    let statusC = statusCode.toInt() ?? 0
                    
                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        if let index = self.indexPath {
                            print("delegate")
                            self.delegate?.updateCell(indexPath: index, value: "1", action: "favorite")
                        }
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            }
        }
        else if (UIImage(named:"star")?.isEqual(self.saveOrDeleteImage.image!))!
        {
            self.saveOrDeleteImage.image = UIImage(named:"star_off")
            let request = Requests.createFavoriteOfferRequest((self.offer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
            
            let network = Network()
            let idOf = offer?.idOffer ?? 0
            network.setIdOffert(idOfert: "\(idOf)")
            network.setUrlParameters(urlParameters: request)
            network.endPointN(endPont: .OfferFavorite) { (statusCode, value, objeto) -> (Void) in
                let statusC = statusCode.toInt() ?? 0
                
                if statusC >= 200 && statusC < 300 {
                    print("ya estufas: \(value)")
                    if let index = self.indexPath {
                        print("delegate")
                        self.delegate?.updateCell(indexPath: index, value: "0", action: "favorite")
                    }
                }else {
                    print("Unlike fail")
                    self.likeImage.image = UIImage(named: "like")
                    if let obj = objeto as? ApiError {
                        Commons.showMessage("\(obj.message)", duration: .long)
                    } else {
                        Commons.showMessage("Error de comunicación")
                    }
                }
            }
      }
        else if (UIImage(named:"Trash_off")?.isEqual(self.saveOrDeleteImage.image!))!
        {
            if (self.offer?.isFavorite)!
            {
                let request = Requests.createFavoriteOfferRequest((self.offer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)

                if (offer?.isArticle)!
                {
                    let network = Network()
                    let idoff = offer?.idOffer ?? 0
                    network.setUrlParameters(urlParameters: request)
                    network.setIdOffert(idOfert: "\(idoff)")
                    network.setEnvironment(Environment: ENVIROMENTAPP)
                    network.setConstants(constants: constantsParameters)
                    network.endPointN(endPont: .ArticleFavorite) { (statusCode, value, objeto) -> (Void) in
                        let statusC = statusCode.toInt() ?? 0
                        
                        if statusC >= 200 && statusC < 300 {
                            print("ya estufas: \(value)")
                            if let index = self.indexPath {
                                print("delegate")
                                self.delegate?.updateCell(indexPath: index, value: "0", action: "favorite")
                            }
                        }else {
                            print("Unlike fail")
                            self.likeImage.image = UIImage(named: "like")
                            if let obj = objeto as? ApiError {
                                Commons.showMessage("\(obj.message)", duration: .long)
                            } else {
                                Commons.showMessage("Error de comunicación")
                            }
                        }
                    }
                } else {
                    let network = Network()
                    network.setUrlParameters(urlParameters: request)
                    let idOfert = offer?.idOffer ?? 0
                    network.setIdOffert(idOfert: "\(idOfert)")
                    network.setEnvironment(Environment: ENVIROMENTAPP)
                    network.setConstants(constants: constantsParameters)
                    network.endPointN(endPont: .OfferFavorite) { (statusCode, value, objeto) -> (Void) in
                        let statusC = statusCode.toInt() ?? 0
                        
                        if statusC >= 200 && statusC < 300 {
                            print("ya estufas: \(value)")
                            if let index = self.indexPath {
                                print("delegate")
                                self.delegate?.deleteCell(indexPath: index)
                            }
                        }else {
                            print("Unlike fail")
                            self.likeImage.image = UIImage(named: "like")
                            if let obj = objeto as? ApiError {
                                Commons.showMessage("\(obj.message)", duration: .long)
                            } else {
                                Commons.showMessage("Error de comunicación")
                            }
                        }
                    }
                }
            }
            else
            {
                self.saveOrDeleteImage.image = UIImage(named:"Trash")
                let request = Requests.createDeleteOfferRequest()
                
                let network = Network()
                let ofet = offer?.idOffer ?? 0
                network.setIdOffert(idOfert: "\(ofet)")
                network.setUrlParameters(urlParameters: request)
                network.setEnvironment(Environment: ENVIROMENTAPP)
                network.setConstants(constants: constantsParameters)
                network.endPointN(endPont: .OfferDelete) { (statusCode, value, objeto) -> (Void) in
                    let statusC = statusCode.toInt() ?? 0
                    
                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        if let index = self.indexPath {
                            print("delegate")
                            self.delegate?.deleteCell(indexPath: index)
                        }
                    }else {
                        print("delete fail")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            }
        }
        else if (UIImage(named:"Trash")?.isEqual(self.saveOrDeleteImage.image!))!
        {
            self.saveOrDeleteImage.image = UIImage(named:"Trash_off")
        }
    }
    
    @objc func like(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("like")
        if (UIImage(named:"like")?.isEqual(self.likeImage.image!))!
        {
            self.likeImage.image = UIImage(named: "like_on")
            self.dislikeImage.image = UIImage(named: "dislike")
            if self.saveOrDeleteImage.isHidden || !(UIImage(named: "star_off")?.isEqual(self.saveOrDeleteImage.image!))!
            {
                self.saveOrDeleteImage.isHidden = false
                self.saveOrDeleteImage.image = UIImage(named: "star_off")
            }
            let parameters = Requests.createRateOfferRequest(5, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
            let network = Network()
            network.setUrlParameters(urlParameters: parameters)
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setConstants(constants: constantsParameters)
            let idOfer = offer?.idOffer ?? 0
            network.setIdOffert(idOfert: "\(idOfer)")
            if (offer?.isArticle)! {

                network.endPointN(endPont: .ArticleRating) { (StatusCode, value, objeto) -> (Void) in
                    let statusC = StatusCode.toInt() ?? 0

                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        if let index = self.indexPath {
                            print("delegate")
                            self.delegate?.updateCell(indexPath: index, value: "5", action: "likes")
                        }
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            }
            else
            {

                network.endPointN(endPont: .OfferRating) { (StatusCode, value, objeto) -> (Void) in
                    let statusC = StatusCode.toInt() ?? 0

                    print("valuevaluevalue: \(value)")
                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        if let index = self.indexPath {
                            print("delegate")
                            self.delegate?.updateCell(indexPath: index, value: "5", action: "likes")
                        }
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            }
        }
        else
        {
            self.likeImage.image = UIImage(named: "like")
            self.saveOrDeleteImage.isHidden = true
            let request = Requests.createRateOfferRequest(3, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)

            let network = Network()
            let idOfer = offer?.idOffer ?? 0
            network.setIdOffert(idOfert: "\(idOfer)")
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setConstants(constants: constantsParameters)
            network.setUrlParameters(urlParameters: request)
            if (self.offer?.isArticle)!
            {
                network.endPointN(endPont: .ArticleRating) { (statusCode, value, objeto) -> (Void) in
                    let statusC = statusCode.toInt() ?? 0

                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        self.delegate?.updateCell(indexPath: self.indexPath!, value: "3", action: "")
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like_on")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            } else {
                network.endPointN(endPont: .OfferRating) { (statusCode, value, objeto) -> (Void) in
                    let statusC = statusCode.toInt() ?? 0

                    if statusC >= 200 && statusC < 300 {
                        print("ya estufas: \(value)")
                        self.delegate?.updateCell(indexPath: self.indexPath!, value: "3", action: "")
                    }else {
                        print("Unlike fail")
                        self.likeImage.image = UIImage(named: "like_on")
                        if let obj = objeto as? ApiError {
                            Commons.showMessage("\(obj.message)", duration: .long)
                        } else {
                            Commons.showMessage("Error de comunicación")
                        }
                    }
                }
            }
        }
    }
    
    @objc func dislike(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("dislike")
        if (UIImage(named:"dislike")?.isEqual(self.dislikeImage.image!))!
        {
            self.dislikeImage.image = UIImage(named: "dislike_on")
            self.likeImage.image = UIImage(named: "like")
            if (self.saveOrDeleteImage.isHidden || !(UIImage(named: "Trash_off")?.isEqual(self.saveOrDeleteImage.image!))!) && (self.offer?.isHome)!
            {
                self.saveOrDeleteImage.isHidden = false
                self.saveOrDeleteImage.image = UIImage(named: "Trash_off")
            }

            let request = Requests.createRateOfferRequest(1, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)

            
            let network = Network()
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setConstants(constants: constantsParameters)
            network.setUrlParameters(urlParameters: request)
            network.setIdOffert(idOfert: "\(self.offer?.idOffer ?? 0)")
            
            if (offer?.isArticle)! {
                network.endPointN(endPont: .ArticleRating) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
//                        let info = ["action" : "likes", "value" : "1", "idOffer" : "\(self.offer?.idOffer ?? 0)"]
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "1", action: "likes")
                        }
                    } else {
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                        print("Dislike fail")
                    }
                }
            }
            else
            {
                network.endPointN(endPont: .OfferRating) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                        print("Dislike sucess")
//                        let info = ["action" : "likes", "value" : "1", "idOffer" : "\(self.offer?.idOffer ?? 0)"]
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "1", action: "likes")
                        }
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
                    } else {
                        print("Dislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                    }
                }
            }

            let request2 = Requests.createFavoriteOfferRequest((self.offer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)


            let network2 = Network()
            network2.setEnvironment(Environment: ENVIROMENTAPP)
            network2.setConstants(constants: constantsParameters)
            network2.setUrlParameters(urlParameters: request2)
            network2.setIdOffert(idOfert: "\(self.offer?.idOffer ?? 0)")
            
            
            if (offer?.isArticle)! {
                network2.endPointN(endPont: .ArticleFavorite) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                        print("Unfavorite sucess")
//                        let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "0", action: "favorite")
                        }
                    } else {
                        print("Unfavorite fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                    }
                }
            } else {
                network2.endPointN(endPont: .OfferFavorite) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                        print("Unfavorite sucess")
//                        let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
                        
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "0", action: "favorite")
                        }
                    } else {
                        print("Unfavorite fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                    }
                }
            }
            
            
            
            if (self.offer?.isFavorite)! {
                
                let request3 = Requests.createFavoriteOfferRequest((self.offer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
                
                let network3 = Network()
                network3.setEnvironment(Environment: ENVIROMENTAPP)
                network3.setConstants(constants: constantsParameters)
                network3.setUrlParameters(urlParameters: request3)
                network3.setIdOffert(idOfert: "\(self.offer?.idOffer ?? 0)")
                
                if (offer?.isArticle)! {
                    
                    
                    network3.endPointN(endPont: .ArticleFavorite) { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
                            
                            if let index = self.indexPath {
                                self.delegate?.deleteCell(indexPath: index)
                            }
                        } else {
                            print("Unfavorite fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                        }
                    }
                } else{
                    
                    
                    network3.endPointN(endPont: .OfferFavorite) { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
                            if let index = self.indexPath {
                                self.delegate?.deleteCell(indexPath: index)
                            }
                        } else {
                            print("Unfavorite fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                        }
                    }
                }
            }
            else
            {
                self.saveOrDeleteImage.image = UIImage(named:"Trash")
                let request = Requests.createDeleteOfferRequest()
                
                
                let network4 = Network()
                network4.setEnvironment(Environment: ENVIROMENTAPP)
                network4.setConstants(constants: constantsParameters)
                network4.setUrlParameters(urlParameters: request)
                network4.setIdOffert(idOfert: "\(self.offer?.idOffer ?? 0)")
                
                
                if (offer?.isArticle)! {
                    network4.endPointN(endPont: .ArticleDelete) { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                            print("Delete sucess")
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
                            if let index = self.indexPath {
                                self.delegate?.deleteCell(indexPath: index)
                            }
                        } else {
                            print("Delete fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                        }
                    }
                } else {
                    network4.endPointN(endPont: .OfferDelete) { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                            print("Delete sucess")
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
                            if let index = self.indexPath {
                                self.delegate?.deleteCell(indexPath: index)
                            }
                        } else {
                            print("Delete fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                        }
                    }
                }
            }
        } else {
            self.dislikeImage.image = UIImage(named: "dislike")
            self.saveOrDeleteImage.isHidden = true
            let request = Requests.createRateOfferRequest(3, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
            
            
            let network5 = Network()
            network5.setEnvironment(Environment: ENVIROMENTAPP)
            network5.setConstants(constants: constantsParameters)
            network5.setUrlParameters(urlParameters: request)
            network5.setIdOffert(idOfert: "\(self.offer?.idOffer ?? 0)")

            if (offer?.isArticle)! {
                
                network5.endPointN(endPont: .ArticleRating) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                        print("Undislike sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "5", action: "likes")
                        }
                    } else {
                        print("Undislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                    }
                }
            } else {
                network5.endPointN(endPont: .OfferRating) { (statusCode, value, objeto) -> (Void) in
                    if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                        print("Undislike sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
                        if let index = self.indexPath {
                            self.delegate?.updateCell(indexPath: index, value: "5", action: "likes")
                        }
                    } else {
                        print("Undislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
                    }
                }
            }
        }
    }
    
}
