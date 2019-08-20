//
//  OfferCount.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class OfferCount: Mappable
{
    var count = 0
    var categories : [Category] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        categories <- map["categories"]
    }
}
