//
//  LocationGeofence.swift
//  Yopter
//
//  Created by Victor Hernandez on 2/18/18.
//  Copyright © 2018 Yopter. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationGeofence: Mappable{
    var latitude : Double = 0
    var longitude : Double = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
