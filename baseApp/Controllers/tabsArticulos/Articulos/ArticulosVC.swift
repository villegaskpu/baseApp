//
//  ArticulosVC.swift
//  baseApp
//
//  Created by David on 9/9/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class ArticulosVC: BTableViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titulo: UILabel!
    
    var items = InfoManager()
    var pageArticulos = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableItems.removeAll()
        tableView.alpha = 0
        
        
        titulo.font = UIFont.titulosInterior
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .articulosCell)
        
//        TableViewCellFactory.registerCells(tableView: tableView, identifiers: "ArticulosCell")
        getArticulos()
    }
    
    
    
    func getArticulos() {
        showLoading()
        
        let params = ["search" : ["value" : "", "page" : pageArticulos, "rows" : 25]] as [String : Any]
        
        let network = Network()
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setConstants(constants: constantsParameters)
        network.setUrlParameters(urlParameters: params)
        
        network.endPointN(endPont: .GetArticles) { (statusCode, value, objeto) -> (Void) in
            
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let oferts = objeto as? [Offer] {
                    self.tableItems.set(section: "")
                    for a in oferts {
                        //                    print("oddfddd: \(a.title)")
                        let ofert = InfoItem(identifier: "articulos", type:  .articulosCell, title: "", value: "")
                        ofert.offer = a
                        self.tableItems.append(item: ofert)
                    }
                    self.tableView.reloadData()
                    UIView.animate(withDuration: 2.0, animations: {
                        self.tableView.alpha = 1
                    })
                } else {
                    Commons.showMessage("GLOBAL_ERROR".localized)
                }
                
                
                self.hideLoading()
            } else {
                print("value error: \(value)")
                self.hideLoading()
                
                self.tableItems.set(section: "Sin resultados")
                self.tableView.reloadData()
                UIView.animate(withDuration: 2.0, animations: {
                    self.tableView.alpha = 1
                })
                if let val = objeto as? ApiError {
                    Commons.showMessage("\(val.message)", duration: TTGSnackbarDuration.long)
                } else {
                    Commons.showMessage("GLOBAL_ERROR".localized)
                }
            }
        }
    }
}
