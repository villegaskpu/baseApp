//
//  BeaconInstallationType.swift
//  Yopter
//
//  Created by Yoptersys on 6/8/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class BeaconInstallationType :Mappable
{
    var idBeaconInstallationType = 0
    var name : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idBeaconInstallationType <- map["idBeaconInstallationType"]
        name <- map["name"]
    }
}
