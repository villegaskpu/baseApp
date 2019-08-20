//
//  ArticlesResponse.swift
//  Push
//
//  Created by Victor Hernandez on 8/3/18.
//  Copyright © 2018 Yopter. All rights reserved.
//

import ObjectMapper

class ArticlesResponse : Mappable{
    var draw : Int = 0
    var recordsTotal : Int = 0
    var recordsFiltered : Int = 0
    var data : [Article] = []
    
    required init?(map: Map) { }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        draw <- map["draw"]
        recordsTotal <- map["recordsTotal"]
        recordsFiltered <- map["recordsFiltered"]
        data <- map["data"]
    }
}
