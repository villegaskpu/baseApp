//
//  Beacon.swift
//  Yopter
//
//  Created by Yoptersys on 6/7/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Beacon : Mappable
{
    var uuid : String = ""
    var major = 0
    var minor = 0
    var temperature = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        major <- map["major"]
        minor <- map["minor"]
        temperature <- map["temperature"]
    }
}
