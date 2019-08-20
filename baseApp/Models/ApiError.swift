//
//  ApiError.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class ApiError: Mappable
{
    var code : String = ""
    var message : String = ""
    var cause : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        cause <- map["cause"]
    }
}
