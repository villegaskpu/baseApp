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
        
        titulo.font = UIFont.label
        valor.font = UIFont.label
        
        titulo.textColor = UIColor.warmGrey
        valor.textColor = UIColor.black
       
//        valor.addTarget(self, action: #selector(textChange), for: .editingChanged)
        valor.delegate = self
    }

    override func prepareForReuse() {
        contraintHeightTitulo.constant = 25
        titulo.font = UIFont.label
        valor.font = UIFont.label
        
        titulo.textColor = UIColor.warmGrey
        valor.textColor = UIColor.black
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

extension textField:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let _ = indexPath {
            delegate?.yopterTextFieldChange(textField: valor, indexPath: indexPath!, text: valor.text!)
        }
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        print("reason: \(reason)")
//    }
}
