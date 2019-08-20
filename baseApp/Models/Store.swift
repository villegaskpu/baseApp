//
//  Store.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Store:  Mappable
{
    
    var idStore = 0
    var name: String = ""
    var addressL1 : String = ""
    var addressL2 : String = ""
    var zipCode : String = ""
    var city : String = ""
    var state : State = State ()
    var email : String = ""
    var latitude : Double = 0
    var longitude : Double = 0
    var distance : Double = 0
    var phoneNumber : String = ""
    var website : String = ""
    var imgURL : String = ""
    var virtualCommerce = 0
    var mall : Mall = Mall ()
    var schedules : [Schedule] = []
    var offers : [Offer] = []
    var commerce : Commerce = Commerce ()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idStore <- map["idStore"]
        name <- map["name"]
        addressL1 <- map["addressL1"]
        addressL2 <- map["addressL2"]
        zipCode <- map["zipCode"]
        city <- map["city"]
        state <- map["state"]
        email <- map["email"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        distance <- map["distance"]
        phoneNumber <- map["phoneNumber"]
        website <- map["website"]
        imgURL <- map["imgURL"]
        virtualCommerce <- map["virtualCommerce"]
        mall <- map["mall"]
        schedules <- map["schedules"]
        offers <- map["offers"]
        commerce <- map["commerce"]
    }
}
