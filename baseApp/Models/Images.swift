//
//  Images.swift
//  Yopter Camaleonica
//
//  Created by David on 4/24/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import ObjectMapper

class Images: Mappable
{
    var headerURL : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        headerURL <- map["headerURL"]
    }
}
