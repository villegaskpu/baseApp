//
//  Showed.swift
//  Yopter
//
//  Created by Yoptersys on 6/1/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Showed : Mappable
{
    var idOffer = 0
    var latitude : Double = 0
    var longitude : Double = 0
    var position = 0
    var page = 0
    var date : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idOffer <- map["idOffer"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        position <- map["position"]
        page <- map["page"]
        date <- map["date"]
    }
}
