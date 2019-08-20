//
//  BeaconDetail.swift
//  Yopter
//
//  Created by Yoptersys on 6/8/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class BeaconDetail : Mappable
{
    var idBeacon = 0
    var beaconType : String =  ""
    var uuid : String = ""
    var major = 0
    var minor = 0
    var beaconFirmware : BeaconFirmware = BeaconFirmware ()
    var broadcastingPower = 0
    var beaconInstallation : BeaconInstallation = BeaconInstallation ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idBeacon <- map["idBeacon"]
        beaconType <- map["beaconType"]
        uuid <- map["uuid"]
        major <- map["major"]
        minor <- map["minor"]
        beaconFirmware <- map["beaconFirmware"]
        broadcastingPower <- map["broadcastingPower"]
        beaconInstallation <- map["beaconInstallation"]
    }
}
