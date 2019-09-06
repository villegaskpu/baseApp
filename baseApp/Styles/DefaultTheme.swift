//
//  DefaultTheme.swift
//  Yopter Camaleonica
//
//  Created by David on 4/23/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit

struct DefaultTheme: Theme {
    //    let tint: UIColor = .black
    //    let secondaryTint: UIColor = .green
    let header : UIColor = UIColor.hexStringToUIColor(hex: "#0076B3")
    let backgroundColor: UIColor = UIColor.hexStringToUIColor(hex: "#0076B3")
    let backgroundButtonColor: UIColor = UIColor.hexStringToUIColor(hex: "#6ACCD2")
    let titleBackground: UIColor = UIColor.hexStringToUIColor(hex: "#854399")
    
    
    //    let separatorColor: UIColor = .lightGray
    //    let selectionColor: UIColor = .init(red: 38/255, green: 38/255, blue: 40/255, alpha: 1)
    
    //    let labelColor: UIColor = .white
    //    let secondaryLabelColor: UIColor = .lightGray
    //    let subtleLabelColor: UIColor = .darkGray
    //
    let barStyle: UIBarStyle = .default
}
