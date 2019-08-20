//
//  Mall.swift
//  Yopter
//
//  Created by Yopter Big Data on 21/06/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Mall : Mappable
{
    var idMall = 0
    var name : String = ""
    var zoneImg : [ZoneImg] = []
    var logoURL : String = ""
    var countStore = 0
    var countOffer = 0
    var estimatedSavingsOffers = 0
    var notify : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idMall <- map["idMall"]
        name <- map["name"]
        zoneImg <- map["zoneImg"]
        logoURL <- map["logoURL"]
        countStore <- map["countStore"]
        countOffer <- map["countOffer"]
        estimatedSavingsOffers <- map["estimatedSavingsOffers"]
        notify <- map["notify"]
    }
}
