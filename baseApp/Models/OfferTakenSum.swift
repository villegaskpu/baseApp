//
//  OfferTakenSum.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferTakenSum : Mappable
{
    var sumAllUsers = 0
    var sumMine = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        sumAllUsers <- map["sumAllUsers"]
        sumMine <- map["sumMine"]
    }
}
