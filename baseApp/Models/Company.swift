//
//  Companies.swift
//  Yopter Camaleonica
//
//  Created by David on 4/30/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import ObjectMapper

class Company: Mappable {
    
    var idCompany = 0
    var name = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idCompany <- map["idCompany"]
        name <- map["name"]
    }
}
