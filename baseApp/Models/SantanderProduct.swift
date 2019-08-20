//
//  SantanderProduct.swift
//  Yopter
//
//  Created by Yoptersys on 4/19/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class SantanderProduct: Mappable
{
    var idCode : String = ""
    var idProduct = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idCode <- map["idCode"]
        idProduct <- map["idProduct"]
    }
}
