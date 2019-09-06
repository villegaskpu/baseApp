//
//  InfoSession.swift
//  SeekOp
//
//  Created by DESARROLLOSICOP on 23/07/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

class InfoSession: UITableViewCell {

    @IBOutlet weak var imageContent: UIView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var distribuidor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        selectionStyle = .none
        
        imageContent.shadow(cornerRadius: 30)
        
        nombre.font = UIFont.colorTextMenu
        nombre.textColor = .white
        nombre.adjustsFontSizeToFitWidth = true
        nombre.minimumScaleFactor = 0.3
        
        correo.font = UIFont.colorTextMenu
        correo.textColor = .darkGray
        correo.adjustsFontSizeToFitWidth = true
        correo.minimumScaleFactor = 0.3
        
        distribuidor.font = UIFont.colorTextMenu
        distribuidor.textColor = .darkGray
        distribuidor.adjustsFontSizeToFitWidth = true
        distribuidor.minimumScaleFactor = 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
