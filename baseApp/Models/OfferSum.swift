//
//  OfferSum.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferSum : Mappable
{
    var sum = 0
    var categories : [Category] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        sum <- map["sum"]
        categories <- map["categories"]
    }
}
