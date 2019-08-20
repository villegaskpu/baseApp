//
//  UserStatus.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class UserStatus: Mappable
{
    
    var idUserStatus = 0
    var name : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idUserStatus <- map["idUserStatus"]
        name <- map["name"]
    }
}
