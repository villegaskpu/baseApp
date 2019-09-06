//
//  VycoTheme.swift
//  baseApp
//
//  Created by David on 9/6/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit

struct VycoTheme:Theme {
    let header : UIColor = UIColor.hexStringToUIColor(hex: "#0076B3")
    let backgroundColor: UIColor = UIColor.hexStringToUIColor(hex: "#0076B3")
    let backgroundButtonColor: UIColor = UIColor.hexStringToUIColor(hex: "#cf0473")
    let titleBackground: UIColor = UIColor.hexStringToUIColor(hex: "#854399")
    
    let barStyle: UIBarStyle = .default
}
