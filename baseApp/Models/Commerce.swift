//
//  Commerce.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Commerce: Mappable
{
    
    var idCommerce = 0
    var name : String = ""
    var taxReferenceId : String = ""
    var logoURL : String = ""
    var s3LogoURL : String = ""
    var website : String = ""
    var signDate : String = ""
    var stores : [Store] = []
    var keywords : [Keyword] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init(){
    }
    
    func mapping(map: Map) {
        idCommerce <- map["idCommerce"]
        name <- map["name"]
        taxReferenceId <- map["taxReferenceId"]
        logoURL <- map["logoURL"]
        s3LogoURL <- map["s3LogoURL"]
        website <- map["website"]
        signDate <- map["signDate"]
        stores <- map["stores"]
        keywords <- map["keywords"]
    }
}
