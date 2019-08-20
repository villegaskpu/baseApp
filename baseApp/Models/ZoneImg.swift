//
//  RealmString.swift
//  Yopter
//
//  Created by Yopter Big Data on 21/06/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class ZoneImg : Mappable
{
    var idMall = 0
    var name : String = ""
    var urlImg : String = ""
    var idmallZoneImg = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idMall <- map["idMall"]
        name <- map["name"]
        urlImg <- map["urlImg"]
        idmallZoneImg <- map["idmallZoneImg"]
    }
}

