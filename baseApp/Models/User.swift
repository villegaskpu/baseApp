//
//  User.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class User: Mappable
{
    var idUser = 0
    var email : String = ""
    var banned = 0
    var userStatus: UserStatus = UserStatus ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idUser <- map["idUser"]
        email <- map["email"]
        banned <- map["banned"]
        userStatus <- map["userStatus"]
    }
}
