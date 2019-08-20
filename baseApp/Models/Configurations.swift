//
//  Configurations.swift
//  Yopter Camaleonica
//
//  Created by David on 4/24/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import ObjectMapper

class Configurations: Mappable {
    var customColors:CustomColors = CustomColors()
    var images: Images = Images()
    var menu:[Menu] = []
    var refresh = 0
//    var tutorialURL = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        customColors <- map["colors"]
        images <- map["images"]
        menu <- map["menu"]
        refresh <- map["refresh"]
//        tutorialURL <- map["tutorialURL"]
    }
}
