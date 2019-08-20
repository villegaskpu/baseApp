//
//  Image.swift
//  Yopter
//
//  Created by Yoptersys on 4/24/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import ObjectMapper

class Image: Mappable
{
    var imageURL : String = ""
    var s3URL : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        imageURL <- map["imageURL"]
        s3URL <- map["s3URL"]
    }
}
