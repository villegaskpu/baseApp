//
//  pickerViewcell.swift
//  SeekOp
//
//  Created by david villegas santana on 13/02/18.
//  Copyright © 2018 David Villegas Santana. All rights reserved.
//

import UIKit

protocol pickerViewcellDelegate {
    func pikerViewDel(_ index:Int)
}

class pickerViewcell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var items:[(String, String)] = [] {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }
    var status = ""
    var indexPath:IndexPath?
    var estado = ""
    var propuesta = ""
    var delegate:pickerViewcellDelegate?
    
    override func prepareForReuse() {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pikerViewDel(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = items[row].1
        pickerLabel.font = UIFont(name: Font.FONT_BOLD(), size: 19)
        pickerLabel.adjustsFontSizeToFitWidth = true
        pickerLabel.minimumScaleFactor = 0.3
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    //////////

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
