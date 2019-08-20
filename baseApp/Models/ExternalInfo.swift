//
//  ExternalInfo.swift
//  Yopter
//
//  Created by Yoptersys on 4/19/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class ExternalInfo: Mappable
{
    var idExternal : String = ""
    var santanderProduct : SantanderProduct = SantanderProduct ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        idExternal <- map["idExternal"]
        santanderProduct <- map["santanderProduct"]
    }
}

