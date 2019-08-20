//
//  State.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class State: Mappable
{
    var country : Country = Country ()
    var idState = 0
    var name : String = ""
    var abbreviation : String = ""
    var active = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        country <- map["country"]
        idState <- map["idState"]
        name <- map["name"]
        abbreviation <- map["abbreviation"]
        active <- map["active"]
    }
}













