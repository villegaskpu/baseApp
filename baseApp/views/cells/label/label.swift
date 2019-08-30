//
//  label.swift
//  SeekOp
//
//  Created by Daniel Rodriguez on 11/09/16.
//  Copyright © 2016 David Villegas Santana. All rights reserved.
//

import UIKit

class label: UITableViewCell {

    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var contenido: UILabel!
    @IBOutlet weak var tituloHeight: NSLayoutConstraint!

    @IBOutlet weak var viewContent: UIView!
    
    var textAlignmentL:NSTextAlignment = .justified
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contenedor.backgroundColor = .white
//        addShadow(view: contenedor, height: 0.5, width: 1.5, shadowOpacity: 0.2, cornerRadius: 5.0, shadowRadius: 6.0, color: .black)
        
        titulo.font = UIFont(name: Font.FONT_BOLD(), size: Font.SIZE_FONT_BOLD())
        contenido.font = UIFont(name: Font.FONT_REGULAR(), size: 12)
        contenido.numberOfLines = 0
        contenido.adjustsFontForContentSizeCategory = true
        contenido.minimumScaleFactor = 0.9
        
        contenido.textAlignment = textAlignmentL
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
