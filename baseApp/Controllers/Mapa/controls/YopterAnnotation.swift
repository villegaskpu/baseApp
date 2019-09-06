//
//  YopterAnnotation.swift
//  Yopter
//
//  Created by Yoptersys on 6/1/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import MapKit
import a4SysCoreIOS


class YopterAnnotation : MKPointAnnotation
{
    var store : Store?
    
    override init() {
    }
    
    init(_ title: String, subtitle: String, store: Store, coordinate: CLLocationCoordinate2D) {
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.store = store
        self.coordinate = coordinate
    }
}
