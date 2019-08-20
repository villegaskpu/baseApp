//
//  Article.swift
//  Push
//
//  Created by Victor Hernandez on 8/3/18.
//  Copyright © 2018 Yopter. All rights reserved.
//

import ObjectMapper

class Article : Mappable{
    var idArticle = 0
    var title : String = ""
    var articleDescription : String = ""
    var websiteURL : String = ""
    var images : [Image] = []
    var permanent = 0
    var offerStatus : OfferStatus = OfferStatus ()
    var viewed = 0
    var favorite = 0
    var rating : Rating =  Rating ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idArticle <- map["idArticle"]
        title <- map["title"]
        articleDescription <- map["description"]
        websiteURL <- map["websiteURL"]
        permanent <- map["permanent"]
        offerStatus <- map["offerStatus"]
        images <- map["images"]
        viewed <- map["viewed"]
        favorite <- map["favorite"]
        rating <- map["rating"]
    }
}
