//
//  ReportReason.swift
//  Yopter
//
//  Created by Yoptersys on 4/25/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class ReportReason : Mappable
{
    var idReportReason = 0
    var name : String = ""
    var reasonDescription : String = ""
    var createdAt : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idReportReason <- map["idReportReason"]
        name <- map["name"]
        reasonDescription <- map["description"]
        createdAt <- map["createdAt"]
    }
}
