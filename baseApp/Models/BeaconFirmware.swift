//
//  BeaconFirmware.swift
//  Yopter
//
//  Created by Yoptersys on 6/8/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class BeaconFirmware : Mappable
{
    var idBeaconFirmware = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idBeaconFirmware <- map["idBeaconFirmware"]
    }
}
