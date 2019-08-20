//
//  FiltersCategories.swift
//  mi2
//
//  Created by David on 7/12/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import ObjectMapper

class FiltersCategories : Mappable
{
    var idCategoryAlias : Int?
    var name : String?
    var iconUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        idCategoryAlias <- map["idCategoryAlias"]
        name <- map["name"]
        iconUrl <- map["iconUrl"]
    }
}
