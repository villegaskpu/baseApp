//
//  OfferTaken.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferTaken : Mappable
{
    var allUsers = 0
    var mine = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        allUsers <- map["allUsers"]
        mine <- map["mine"]
    }
}
