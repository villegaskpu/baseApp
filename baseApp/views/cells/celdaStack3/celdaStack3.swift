//
//  celdaStack3.swift
//  SeekOp
//
//  Created by David Villegas Santana on 06/10/17.
//  Copyright © 2017 David Villegas Santana. All rights reserved.
//

import UIKit


protocol celdaStack3Delegate {
    func selectBtn(value:Int)
}

class celdaStack3: UITableViewCell {

    @IBOutlet weak var firstBox: UIView!
    @IBOutlet weak var thirdBox: UIView!
    
    
    @IBOutlet weak var btnUno: UIButton!
    @IBOutlet weak var btnDos: UIButton!
    
    
    var delegate: celdaStack3Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUno.titleLabel?.adjustsFontSizeToFitWidth = true
        btnUno.titleLabel?.minimumScaleFactor = 0.5
        btnUno.titleLabel?.numberOfLines = 2
        btnUno.titleLabel?.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        btnUno.titleLabel?.font = UIFont(name: Font.FONT_BOLD(), size: 11)
        btnUno.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        
        btnDos.titleLabel?.adjustsFontSizeToFitWidth = true
        btnDos.titleLabel?.minimumScaleFactor = 0.5
        btnDos.titleLabel?.numberOfLines = 2
        btnDos.titleLabel?.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        btnDos.titleLabel?.font = UIFont(name: Font.FONT_BOLD(), size: 11)
        btnDos.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func actionUno(_ sender: Any) {
        delegate?.selectBtn(value: 1)
    }
    
    @IBAction func actionDos(_ sender: Any) {
        delegate?.selectBtn(value: 2)
    }

}
