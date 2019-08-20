//
//  BeaconInstallation.swift
//  Yopter
//
//  Created by Yoptersys on 6/8/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class BeaconInstallation : Mappable
{
    var store : Store = Store ()
    var radio = 0
    var forcePush = 0
    var beaconInstallationType : BeaconInstallationType = BeaconInstallationType ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        store <- map["store"]
        radio <- map["radio"]
        forcePush <- map["forcePush"]
        beaconInstallationType <- map["beaconInstallationType"]
    }
}
