//
//  BeaconAnnouncement.swift
//  Yopter
//
//  Created by Yoptersys on 6/7/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class BeaconAnnouncement : Mappable
{
    var beacon : Beacon = Beacon ()
    var enterDate : String = ""
    var exitDate : String = ""
    var proximity : String = ""
    var minDistance = 0
    var maxDistance = 0
    var date : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        beacon <- map["beacon"]
        enterDate <- map["enterDate"]
        exitDate <- map["exitDate"]
        proximity <- map["proximity"]
        minDistance <- map["minDistance"]
        maxDistance <- map["maxDistance"]
        date <- map["date"]
    }
}
