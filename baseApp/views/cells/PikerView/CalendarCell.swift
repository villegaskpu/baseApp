//
//  CalendarCell.swift
//  baseApp
//
//  Created by David on 9/13/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
enum typePikerView  {
    case pikerView
    case datePiker
}

class CalendarCell: UITableViewCell {
    
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var valorTextFiel: UITextField!
    var arrayList:[(String, String)] = []
    var indexPath:IndexPath?
    var type:typePikerView = .datePiker{
        didSet{
            setPikerType()
        }
    }
    
    var delegate: YopterTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    private func setStyle() {
        titulo.font = UIFont.label
        titulo.textColor = UIColor.warmGrey
        
        valorTextFiel.font = UIFont.label
        valorTextFiel.textColor = UIColor.warmGrey
    }
    
    private func setPikerType() {
        if type == .datePiker {
            setDatePiker()
        } else {
            setPikerView()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setDatePiker() {
        let datePicker =  UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale.init(localeIdentifier: "es_MX") as Locale
        datePicker.setDate(Date(), animated: true)
        datePicker.addTarget(self, action: #selector(self.updateTextField), for: UIControl.Event.valueChanged)
        valorTextFiel.inputView = datePicker
        self.valorTextFiel.delegate = self
        self.valorTextFiel.tag = 400
    }
    
    private func setPikerView() {
        let genderPicker = UIPickerView.init()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        self.valorTextFiel.delegate = self
        self.valorTextFiel.tag = 200
        self.valorTextFiel.inputView = genderPicker
    }
    
    @objc func updateTextField() {
        let picker = self.valorTextFiel.inputView as! UIDatePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.valorTextFiel.delegate = self
        self.valorTextFiel.text = dateFormatter.string(from: picker.date)
        
        
    }
}

extension CalendarCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            print("aqui estoy")
        let text = textField.text ?? ""
        if text.count > 4 {
            self.delegate?.yopterTextFieldChange(textField: textField, indexPath: self.indexPath!, text: textField.text ?? "")
        }
    }
}

extension CalendarCell: UIPickerViewDataSource, UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayList[row].1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.valorTextFiel.text = arrayList[row].1
    }
}
