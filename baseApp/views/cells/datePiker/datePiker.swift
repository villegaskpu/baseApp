//
//  datePiker.swift
//  SeekOp
//
//  Created by David Villegas Santana on 10/09/16.
//  Copyright © 2016 David Villegas Santana. All rights reserved.
//

import UIKit

protocol datePickeProtocol{
    func dateSelected(date: Date,indexPath:IndexPath)
}

protocol datePickeProtocol2{
    func dateSelected(date: Date,dateString:String,indexPath:IndexPath)
}

class datePiker: UITableViewCell {

    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var contraintHeight: NSLayoutConstraint!
    
    var indexPath : IndexPath?
    var delegate : datePickeProtocol?
    var delegate2 : datePickeProtocol2?
    var dateString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contenedor.backgroundColor = .white
//        addShadow(view: contenedor, cornerRadius: 6.0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        datePicker.minimumDate = Date()
        datePicker.locale = NSLocale.init(localeIdentifier: "es_MX") as Locale
        titulo.backgroundColor = .clear
        titulo.textAlignment = .left
        titulo.textColor = .black
        titulo.font = UIFont(name: Font.FONT_BOLD(), size: 14.0)
        
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
    }
    
    override func prepareForReuse() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    private func selectDate() {
        if let _ = indexPath {
            delegate?.dateSelected(date: datePicker.date, indexPath: indexPath!)
//            let fecha = datePicker.date.toString(false, format: "yyyy-MM-dd HH:mm:ss")
//            delegate2?.dateSelected(date: datePicker.date, dateString: fecha,indexPath: indexPath!)
        }
    }
    
}
