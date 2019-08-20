//
//  Heartbeat.swift
//  Yopter
//
//  Created by Yoptersys on 6/6/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Heartbeat : Mappable
{
    var latitude : Double = 0
    var longitude : Double = 0
    var beatAt : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        beatAt <- map["beatAt"]
    }
}

