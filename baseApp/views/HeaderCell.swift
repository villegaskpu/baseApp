//
//  HeaderCell.swift
//  SeekOp
//
//  Created by Daniel Rodriguez on 07/11/17.
//  Copyright © 2017 David Villegas Santana. All rights reserved.
//

import UIKit

class HeaderCell: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title: String, textalignment: NSTextAlignment = .center, style: UITableView.Style = .plain) {
        
        if style == .plain {
            super.init(frame: CGRect(x: 0.0, y: 0.0, width: Screen.width, height: 30.0))
            
//            backgroundColor = colorAzul
            backgroundColor = UIColor.blue
            textColor = .white
            text = title.uppercased()
            font = UIFont(name: Font.FONT_REGULAR(), size: 16.0)
            textAlignment = textalignment
        }
        else {
            super.init(frame: CGRect(x: 10, y: 0, width: Screen.width - 20.0, height: 40.0))
            
            text = title
            textColor = .darkGray
            textAlignment = .center
//            font = UIFont(name: FONT_HEAVY_ITALIC, size: 20.0)
            font = UIFont(name: Font.FONT_HEAVY_ITALIC(), size: 20.0)
        }
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
    }
}
