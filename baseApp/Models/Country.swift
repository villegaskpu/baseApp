//
//  Country.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Country: Mappable
{
    var idCountry = 0
    var name : String = ""
    var isoCode2 : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idCountry <- map["idCountry"]
        name <- map["name"]
        isoCode2 <- map["isoCode2"]
    }
}
