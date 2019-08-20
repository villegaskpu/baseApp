//
//  UserCount.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class UserCount : Mappable
{
    var count = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    init() {
    }
    
    func mapping(map: Map) {
        count <- map["count"]
    }
}
