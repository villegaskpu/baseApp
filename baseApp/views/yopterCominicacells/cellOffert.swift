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

class cellOffert: UITableViewCell {
    
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var offertTitle: UILabel!
    @IBOutlet weak var offertDistance: UILabel!
    
    
    // botones
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var saveOrDeleteImage: UIImageView!
    
    // imagenes
    @IBOutlet weak var newIndicator: UIImageView!
    @IBOutlet weak var offertImage: UIImageView!
    @IBOutlet weak var companyLogo: UIImageView!
    
    var indexPath:IndexPath?

    
    var offer: Offer? {
        didSet {
            guard let off = offer else {return}
            companyName.text = off.commerce.name
            offertTitle.text = off.title
            validDistanceOfert(off: off)
            setImageLogo(infoCell: off)
            setActions()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        offertDistance.adjustsFontSizeToFitWidth = true
        offertDistance.minimumScaleFactor = 0.3
        newIndicator.isHidden = true
    }
    
    override func prepareForReuse() {
        newIndicator.isHidden = true
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
                if let city = off.commerce.stores.first?.city {
                    offertDistance.text = String(format: "%@", city)
                } else {
                    offertDistance.text = String(format: "%.02f km", distance)
                }
            } else {
                offertDistance.text = String(format: "%.02f km", distance)
            }
        } else {
            offertDistance.isHidden = true
        }
        
        if off.virtual > 0
        {
            offertDistance.text = "Oferta web"
        }
    }
    
    func setImageLogo(infoCell:Offer) {
        var commerceLogo = infoCell.commerce.s3LogoURL != "" ? (infoCell.commerce.logoURL != "" ? infoCell.commerce.logoURL : nil) : nil
        var offerImageP = infoCell.images.first?.s3URL != "" ? (infoCell.images.first?.imageURL != "" ? infoCell.images.first?.imageURL : nil) : nil
        offerImageP = offerImageP ?? commerceLogo
        commerceLogo = offerImageP == commerceLogo ? nil : commerceLogo
        
        _ = commerceLogo != nil ? (companyLogo.sd_setImage(with: URL.init(string: (commerceLogo?.replacingOccurrences(of: "{1}", with: "100").replacingOccurrences(of: "{2}", with: "full"))!), placeholderImage: nil)) : (companyLogo.isHidden = true)
        
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func saveOrDelete(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("saveOrDelete")
//        if (UIImage(named:"star_off")?.isEqual(self.saveOrDeleteImage.image!))!
//        {
//            self.saveOrDeleteImage.image = UIImage(named:"star")
//            let request = Requests.createFavoriteOfferRequest((self.assignedOffer?.idOffer)!, 1, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            //Acávainalineadecódigo
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Unfavorite sucess")
//                        let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Unfavorite fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//
//
//            sessionManager.request(YopterRouter.OfferFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                {
//                    print("Favorite sucess")
//                    let info = ["action" : "favorite", "value" : "1", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                    NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                }
//                else
//                {
//                    print("Favorite fail")
//                    let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                    print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                }
//            }
//        }
//        else if (UIImage(named:"star")?.isEqual(self.saveOrDeleteImage.image!))!
//        {
//            self.saveOrDeleteImage.image = UIImage(named:"star_off")
//            let request = Requests.createFavoriteOfferRequest((self.assignedOffer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            sessionManager.request(YopterRouter.OfferFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                {
//                    print("Unfavorite sucess")
//                    let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                    NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                }
//                else
//                {
//                    print("Unfavorite fail")
//                    let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                    print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                }            }
//        }
//        else if (UIImage(named:"Trash_off")?.isEqual(self.saveOrDeleteImage.image!))!
//        {
//            if (self.assignedOffer?.isFavorite)!
//            {
//                let request = Requests.createFavoriteOfferRequest((self.assignedOffer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//                if (assignedOffer?.isArticle)!
//                {
//                    sessionManager.request(YopterRouter.ArticleFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                        {
//                            print("Unfavorite sucess")
//                            let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: info)
//                        }
//                        else
//                        {
//                            print("Unfavorite fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                        }
//                    }
//                }
//
//                sessionManager.request(YopterRouter.OfferFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if response.response != nil
//                    {
//                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                        {
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                        }
//                        else
//                        {
//                            print("Unfavorite fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                        }
//                    }
//                }
//            }
//            else
//            {
//                self.saveOrDeleteImage.image = UIImage(named:"Trash")
//                let request = Requests.createDeleteOfferRequest()
//                sessionManager.request(YopterRouter.OfferDelete(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Delete sucess")
//                        let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                    }
//                    else
//                    {
//                        print("Delete fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//        }
//        else if (UIImage(named:"Trash")?.isEqual(self.saveOrDeleteImage.image!))!
//        {
//            self.saveOrDeleteImage.image = UIImage(named:"Trash_off")
//        }
    }
    
    @objc func like(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("like")
//        if (UIImage(named:"like")?.isEqual(self.likeImage.image!))!
//        {
//            self.likeImage.image = UIImage(named: "like_on")
//            self.dislikeImage.image = UIImage(named: "dislike")
//            if self.saveOrDeleteImage.isHidden || !(UIImage(named: "star_off")?.isEqual(self.saveOrDeleteImage.image!))!
//            {
//                self.saveOrDeleteImage.isHidden = false
//                self.saveOrDeleteImage.image = UIImage(named: "star_off")
//            }
//            let request = Requests.createRateOfferRequest(5, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Like sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Like fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            else
//            {
//                sessionManager.request(YopterRouter.OfferRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Like sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Like fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//        }
//        else
//        {
//            self.likeImage.image = UIImage(named: "like")
//            self.saveOrDeleteImage.isHidden = true
//            let request = Requests.createRateOfferRequest(3, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Unlike sucess")
//                        let info = ["action" : "likes", "value" : "3", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Unlike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            else
//            {
//                sessionManager.request(YopterRouter.OfferRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Unlike sucess")
//                        let info = ["action" : "likes", "value" : "3", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Unlike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//        }
    }
    
    @objc func dislike(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("dislike")
//        if (UIImage(named:"dislike")?.isEqual(self.dislikeImage.image!))!
//        {
//            self.dislikeImage.image = UIImage(named: "dislike_on")
//            self.likeImage.image = UIImage(named: "like")
//            if (self.saveOrDeleteImage.isHidden || !(UIImage(named: "Trash_off")?.isEqual(self.saveOrDeleteImage.image!))!) && (self.assignedOffer?.isHome)!
//            {
//                self.saveOrDeleteImage.isHidden = false
//                self.saveOrDeleteImage.image = UIImage(named: "Trash_off")
//            }
//
//            let request = Requests.createRateOfferRequest(1, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Dislike sucess")
//                        let info = ["action" : "likes", "value" : "1", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Dislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            else
//            {
//                sessionManager.request(YopterRouter.OfferRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Dislike sucess")
//                        let info = ["action" : "likes", "value" : "1", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Dislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//
//            }
//
//            let request2 = Requests.createFavoriteOfferRequest((self.assignedOffer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request2)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Unfavorite sucess")
//                        let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Unfavorite fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            else
//            {
//                sessionManager.request(YopterRouter.OfferFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request2)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Unfavorite sucess")
//                        let info = ["action" : "favorite", "value" : "0", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Unfavorite fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            if (self.assignedOffer?.isFavorite)!
//            {
//                let request = Requests.createFavoriteOfferRequest((self.assignedOffer?.idOffer)!, 0, "",LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//                if (assignedOffer?.isArticle)!
//                {
//                    sessionManager.request(YopterRouter.ArticleFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                        if response.response != nil
//                        {
//                            if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                            {
//                                let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                                NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                            }
//                            else
//                            {
//                                print("Unfavorite fail")
//                                let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                                print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                            }
//                        }
//                    }
//                }
//                else{
//                    sessionManager.request(YopterRouter.OfferFavorite(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                        if response.response != nil
//                        {
//                            if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                            {
//                                let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                                NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                            }
//                            else
//                            {
//                                print("Unfavorite fail")
//                                let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                                print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                            }
//                        }
//                    }
//                }
//            }
//            else
//            {
//                self.saveOrDeleteImage.image = UIImage(named:"Trash")
//                let request = Requests.createDeleteOfferRequest()
//
//                if (assignedOffer?.isArticle)!
//                {
//                    sessionManager.request(YopterRouter.ArticleDelete(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                        {
//                            print("Delete sucess")
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                        }
//                        else
//                        {
//                            print("Delete fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                        }
//                    }
//                }
//                else
//                {
//                    sessionManager.request(YopterRouter.OfferDelete(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                        {
//                            print("Delete sucess")
//                            let value = ["idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                            NotificationCenter.default.post(name: .deleteCellNotificationName, object: nil, userInfo: value)
//                        }
//                        else
//                        {
//                            print("Delete fail")
//                            let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                            print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                        }
//                    }
//                }
//            }
//
//        }
//        else
//        {
//            self.dislikeImage.image = UIImage(named: "dislike")
//            self.saveOrDeleteImage.isHidden = true
//            let request = Requests.createRateOfferRequest(3, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
//
//            if (assignedOffer?.isArticle)!
//            {
//                sessionManager.request(YopterRouter.ArticleRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Undislike sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Undislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//            else
//            {
//                sessionManager.request(YopterRouter.OfferRating(idOffer: "\(self.assignedOffer?.idOffer ?? 0)", parameter: request)).response{ (response) in
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("Undislike sucess")
//                        let info = ["action" : "likes", "value" : "5", "idOffer" : "\(self.assignedOffer?.idOffer ?? 0)"]
//                        NotificationCenter.default.post(name: .updateCellNotificationName, object: nil, userInfo: info)
//                    }
//                    else
//                    {
//                        print("Undislike fail")
//                        let apiError = Mapper<ApiError>().map(JSONObject: response.data)
//                        print(apiError?.message ?? "UNNATENDED_ERROR".localized)
//                    }
//                }
//            }
//        }
    }
    
}
