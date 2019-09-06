//
//  MenuOption.swift
//  SeekOp
//
//  Created by DESARROLLOSICOP on 23/07/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

class MenuOption: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titulo.font = UIFont.colorTextMenu
        titulo.textColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
