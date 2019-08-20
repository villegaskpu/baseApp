//
//  UserRating.swift
//  Yopter
//
//  Created by Yopter Big Data on 15/06/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class UserRating: Mappable
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



