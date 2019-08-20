//
//  OfferType.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferType: Mappable
{
    
    var idOfferType = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idOfferType <- map["idOfferType"]
    }
}
