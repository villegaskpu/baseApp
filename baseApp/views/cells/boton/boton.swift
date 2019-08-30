//
//  botonAccion.swift
//  SeekOp
//
//  Created by Daniel Rodriguez on 02/02/17.
//  Copyright © 2017 David Villegas Santana. All rights reserved.
//

import UIKit

protocol botonDelegate {
    func botonPressed(indexPath: IndexPath)
}

class boton: UITableViewCell {

    @IBOutlet weak var boton: UIButton!
    
    var delegate: botonDelegate?
    var indexPath: IndexPath?
    
    var nameImage = "btnEnter"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boton.initButton(boton: boton, textColor: UIColor.white, image: nameImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        if let _ = indexPath {
            delegate?.botonPressed(indexPath: indexPath!)
        }
        else {
            delegate?.botonPressed(indexPath: IndexPath())
        }
    }
}
