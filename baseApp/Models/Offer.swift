//
//  Offer.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Offer: Mappable
{
    
    var idOffer = 0
    var title : String = ""
    var offerDescription : String = ""
    var conditions : String = ""
    var websiteURL: String = ""
    var virtual = 0
    var images : [Image] = []
    var offerType : OfferType = OfferType ()
    var customerRequired = 0
    var permanent = 0
    var offerStatus : OfferStatus = OfferStatus ()
    var keywords : [Keyword] = []
    var categories : [Category] = []
    var commerce : Commerce = Commerce ()
    var viewed = 0
    var deleted = 0
    var favorite = 0
    var rating : Rating = Rating ()
    var userRating : UserRating = UserRating ()
    var createdAt : String = ""
    var endDate : String = ""
    var isHome = false
    var isFavorite = false
    var isArticle = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    convenience init?(article: Article)
    {
        self.init()
        idOffer = article.idArticle
        title = article.title
        offerDescription = article.articleDescription
        websiteURL = article.websiteURL
        images = article.images
        permanent = article.permanent
        offerStatus = article.offerStatus
        viewed = article.viewed
        favorite = article.favorite
        rating = article.rating
    }
    
    func mapping(map: Map) {
        idOffer <- map["idOffer"]
        title <- map["title"]
        offerDescription <- map["description"]
        conditions <- map["conditions"]
        websiteURL <- map["websiteURL"]
        virtual <- map["virtual"]
        images <- map["images"]
        offerType <- map["offerType"]
        customerRequired <- map["customerRequired"]
        permanent <- map["permanent"]
        endDate <- map["endDate"]
        offerStatus <- map["offerStatus"]
        keywords <- map["keywords"]
        categories <- map["categories"]
        commerce <- map["commerce"]
        viewed <- map["viewed"]
        deleted <- map["deleted"]
        rating <- map["rating"]
        userRating <- map["userRating"]
        createdAt <- map["createdAt"]
        favorite <- map["favorite"]
    }
}
