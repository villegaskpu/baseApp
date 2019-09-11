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
            backgroundColor = UIColor.darkHotPink
            textColor = .white
            text = title.uppercased()
            font = UIFont.titleOferta
            textAlignment = textalignment
        }
        else {
            super.init(frame: CGRect(x: 10, y: 0, width: Screen.width - 20.0, height: 40.0))
            backgroundColor = UIColor.darkHotPink
            text = title
            textColor = .white
            textAlignment = .center
//            font = UIFont(name: FONT_HEAVY_ITALIC, size: 20.0)
            font = UIFont.titleOferta
        }
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.3
    }
}
