//
//  Geofence.swift
//  Yopter
//
//  Created by Victor Hernandez on 2/18/18.
//  Copyright © 2018 Yopter. All rights reserved.
//

import Foundation
import ObjectMapper


class Geofence: Mappable
{
    var name: String = ""
    var location : LocationGeofence = LocationGeofence()
    var radio : Double = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        location <- map["location"]
        radio <- map["radio"]
    }
}
