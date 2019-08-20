//
//  Schedule.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Schedule: Mappable
{
    
    var idSchedule = 0
    var weekdays : String = ""
    var openAt : String = ""
    var closedAt : String = ""
    var createdAt : String = ""
    var updatedAt : String = ""
    var breakTimeStart : String = ""
    var breakTimeEnd : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idSchedule <- map["idSchedule"]
        weekdays <- map["weekdays"]
        openAt <- map["openAt"]
        closedAt <- map["closedAt"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        breakTimeStart <- map["breakTimeStart"]
        breakTimeEnd <- map["breakTimeEnd"]
    }
}
