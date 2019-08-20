//
//  CustomColors.swift
//  Yopter Camaleonica
//
//  Created by David on 4/23/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomColors: Mappable {
    
    var background = ""
    var footer = ""
    var header = ""
    var titleBackground = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        background <- map["background"]
        footer <- map["footer"]
        header <- map["header"]
        titleBackground <- map["titleBackground"]
    }
}
