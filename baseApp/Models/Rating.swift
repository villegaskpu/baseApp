//
//  Rating.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Rating: Mappable
{
    var rating : Double = 0
    var count = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    func mapping(map: Map) {
        rating <- map["rating"]
        count <- map["count"]
    }
}
