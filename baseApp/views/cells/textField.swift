//
//  textField.swift
//  SeekOp
//
//  Created by David Villegas on 11/09/16.
//  Copyright © 2016 David Villegas Santana. All rights reserved.
//

import UIKit

protocol YopterTextFieldDelegate {
    func yopterTextFieldChange(textField: UITextField, indexPath: IndexPath, text: String)
}

class textField: UITableViewCell {

    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var valor: UITextField!
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var contraintHeightTitulo: NSLayoutConstraint!
    
    var indexPath:IndexPath?
    
    var delegate: YopterTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        bottomLine.backgroundColor = .clear
        contenedor.backgroundColor = .white
        
//        addShadow(view: contenedor, cornerRadius: 6.0)
        
        titulo.font = UIFont(name: Font.FONT_MEDIUM(), size: Font.SIZE_FONT_MEDIUM())
        valor.font = UIFont(name: Font.FONT_REGULAR(), size: Font.SIZE_FONT_REGULAR())
        
        valor.addTarget(self, action: #selector(textChange), for: .editingChanged)
    }

    override func prepareForReuse() {
        contraintHeightTitulo.constant = 25
        valor.alpha = 1.0
        contenedor.alpha = 1.0
    }
    
//    override func tapPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
//        valor.becomeFirstResponder()
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc private func textChange() {
        if let _ = indexPath {
            delegate?.yopterTextFieldChange(textField: valor, indexPath: indexPath!, text: valor.text!)
        }
    }
}
