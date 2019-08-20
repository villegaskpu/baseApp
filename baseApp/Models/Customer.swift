//
//  Customer.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Customer: Mappable
{
    var idCustomer = 0
    var name : String = ""
    var lastName : String = ""
    var cellPhone : String = ""
    var birthday : String = ""
    var gender : String = ""
    var maritalStatus: MaritalStatus = MaritalStatus ()
    var user : User = User ()
    var state : State = State ()
    var externalInfo : ExternalInfo = ExternalInfo ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        idCustomer <- map["idCustomer"]
        name <- map["name"]
        lastName <- map["lastName"]
        cellPhone <- map["cellPhone"]
        birthday <- map["birthday"]
        gender <- map["gender"]
        maritalStatus <- map["maritalStatus"]
        user <- map["user"]
        state <- map["state"]
        externalInfo <- map["externalInfo"]
    }
}
