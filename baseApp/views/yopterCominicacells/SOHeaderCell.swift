//
//  SOHeaderCell.swift
//  SeekOp
//
//  Created by DESARROLLOSICOP on 13/07/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

class SOHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var left: UIView!
    @IBOutlet weak var right: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        left.backgroundColor = .SOVerde
        left.backgroundColor = UIColor.green
        left.shadow(cornerRadius: 0.5)
        
//        right.backgroundColor = .SOVerde
        right.backgroundColor = UIColor.green
        right.shadow(cornerRadius: 0.5)
        
        contenedor.backgroundColor = .clear
        
//        titulo.textColor = .SOAzul
        titulo.textColor = UIColor.blue
//        titulo.font = UIFont(name: Constants.Font.medium, size: 19.0)
        titulo.font = UIFont(name: Font.FONT_MEDIUM(), size: 15.0)
    }
}
