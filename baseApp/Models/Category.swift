//
//  Category.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Category: Mappable
{
    var idCategory = 0
    var name : String = ""
    var idParentCategory = 0
    var imgURL : String = ""
    var iconURL : String = ""
    var iconUnicode : String = ""
    var categories : [Category] = []
    var offerCount = 0
    var sum = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        idCategory <- map["idCategory"]
        name <- map["name"]
        idParentCategory <- map["idParentCategory"]
        imgURL <- map["imgURL"]
        iconURL <- map["iconURL"]
        iconUnicode <- map["iconUnicode"]
        categories <- map["categories"]
        offerCount <- map["offerCount"]
        sum <- map["sum"]
    }
}
