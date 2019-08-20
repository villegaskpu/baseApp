//
//  WhoAmI.swift
//  Push
//
//  Created by Yopter Big Data on 10/01/18.
//  Copyright © 2018 Yopter. All rights reserved.
//

import ObjectMapper

class WhoAmI : Mappable
{
    var name : String?
    var logoURL : String?
    var message : String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name <- map["name"]
        logoURL <- map["logoURL"]
        message <- map["message"]
    }
}
