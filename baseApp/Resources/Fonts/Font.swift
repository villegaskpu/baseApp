//
//  Font.swift
//  baseApp
//
//  Created by David on 8/21/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import UIKit

class Font: NSObject {
    //titulos
//    public let FONT_MEDIUM = "SFProDisplay-Medium"
//    // botones
//    public let FONT_BOLD = "SFProText-Bold"
    // textos pequeños
//    public let FONT_ITALIC = "SFProText-Light"
//    // letra en general
//    public let FONT_REGULAR = "SFProText-Regular"
//
//    public let FONT_HEAVY = "SFProText-Heavy"
//
//    public let FONT_HEAVY_ITALIC = "SFProText-HeavyItalic"
//
//
//    ////titulos
//    public let FONT_MEDIUM_2 = "AvenirNextCondensed-Medium"
//    // botones
//    public let FONT_BOLD_2 = "AvenirNextCondensed-Bold"
//    // textos pequeños
//    public let FONT_ITALIC_2 = "AvenirNextCondensed-Italic"
//    // letra en general
//    public let FONT_REGULAR_2 = "AvenirNextCondensed-Regular"
    
    
    static func FONT_REGULAR() -> String {
        return "Como-Regular"
    }
    
    static func FONT_MEDIUM() -> String {
        return "Como-Regular"
    }
    
    static func FONT_BOLD() -> String {
        return "Como-Bold"
    }
    
    static func FONT_HEAVY_ITALIC() -> String {
        return "Como-Bold"
    }
    
    static func SIZE_FONT_HEAVY_ITALIC() -> CGFloat {
        return 17.0
    }
    
    static func SIZE_FONT_BOLD() -> CGFloat {
        return 17.0
    }
    
    static func SIZE_FONT_MEDIUM() -> CGFloat {
        return 17.0
    }
    
    static func SIZE_FONT_REGULAR() -> CGFloat {
        return 17.0
    }
}
