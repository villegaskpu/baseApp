//
//  OfferStatus.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferStatus: Mappable
{
    
    var idOfferStatus = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idOfferStatus <- map["idOfferStatus"]
    }
}
