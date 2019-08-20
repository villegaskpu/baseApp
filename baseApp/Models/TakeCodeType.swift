//
//  TakeCodeType.swift
//  Yopter
//
//  Created by Juan Carlos Lopez on 17/05/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class TakeCodeType : Mappable
{
    var idTakeCodeType = 0
    var name : String = ""
    var status : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idTakeCodeType <- map["idTakeCodeType"]
        name <- map["name"]
        status <- map["status"]
    }
}
