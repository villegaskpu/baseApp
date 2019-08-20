//
//  MaritalStatus.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class MaritalStatus: Mappable
{
    var idMaritalStatus = 0
    var name : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idMaritalStatus <- map["idMaritalStatus"]
        name <- map["name"]
    }
}
