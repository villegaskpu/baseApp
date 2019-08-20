//
//  menu.swift
//  Yopter Camaleonica
//
//  Created by David on 4/24/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import ObjectMapper

class Menu: Mappable {
    
    var action:Action = Action ()
    var iconURL = ""
    var name = ""
    var order = 0
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        
        action <- map["action"]
        iconURL <- map["iconURL"]
        name <- map["name"]
        order <- map["order"]
    }
}

class Action: Mappable {
    var URL = ""
    var type = 0
    var webView:Int = 90
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        URL <- map["URL"]
        type <- map["type"]
        webView <- map["webView"]
    }
}
