//
//  TableViewExtension.swift
//  baseApp
//
//  Created by David on 8/23/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit

//MARK: UITableView
extension UITableView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 1.0))
        tableFooterView = UIView()
    }
}
