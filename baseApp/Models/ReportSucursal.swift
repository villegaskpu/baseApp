//
//  ReportSucursal.swift
//  Yopter
//
//  Created by Yopter Big Data on 14/09/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class ReportSucursal : Mappable
{
    var idReportSucursal = 0
    var name : String = ""
    var reasonDescription : String = ""
    var createdAt : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        idReportSucursal <- map["idReportSucursal"]
        name <- map["name"]
        reasonDescription <- map["description"]
        createdAt <- map["createdAt"]
    }
}

