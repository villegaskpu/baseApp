//
//  OffertsVC.swift
//  baseApp
//
//  Created by David on 8/22/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class OffertsVC: BTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items = InfoManager()
    
    var pageHome = 1
    var pageOferts = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        tableView.alpha = 0
        print("hola ofertas")
        BaseDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        //        getHome()
        
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .offertCell)
        
        tableItems.removeAll()
        let parameters = Requests.createSearchOfferRequest("", pageOferts, Constants.numberOfRowsPerPage, 19.401453, -99.275441)
        
        getOferts(parameters: parameters)
    }
    
    
    func checarPermisos() {
        
    }
    
    
    func getHome() {
        
        print("token _:   \(Settings.sharedInstance.getToken())")
        print("agent: \(Commons.getUserAgent())")
        print("token old: \(Settings.sharedInstance.getOldToken())")
        let parameters = Requests.createHomeRequest("", Constants.numberOfRowsPerPage, pageHome, 19.401453, -99.275441)
        
        let network = Network()
        network.setUrlParameters(urlParameters: parameters)
        network.endPointN(endPont: .GetHome) { (statusCode, value, objeto) -> (Void) in
            let statusC = statusCode.toInt() ?? 0
            
            if StatusCode.validateStatusCode(code: statusC) {
                print("value: \(value)")
            } else {
                print("value: \(value)")
            }
        }
    }
    
    func getOferts(isFilter:Bool = false, parameters: [String:Any]) {
        
        
        
        
        let network = Network()
        network.setUrlParameters(urlParameters: parameters)
        network.endPointN(endPont: .OfferSearch) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
//                print("value: \(value)")
                let oferts = objeto as! [Offer]
                
                self.tableItems.set(section: "Ofertas")
                for a in oferts {
//                    print("oddfddd: \(a.title)")
                    let ofert = InfoItem(identifier: "Ofertas", type: .offertCell, title: "", value: "")
                    ofert.offer = a
                    self.tableItems.append(item: ofert)
                }
                self.tableView.reloadData()
                UIView.animate(withDuration: 2.0, animations: {
                    self.tableView.alpha = 1
                })
                self.hideLoading()
            } else {
                print("value: \(value)")
            }
        }
    }
}
extension OffertsVC: BTableViewDelegate {
    func BTableView(tableItems: InfoManager, updateCell indexPath: IndexPath, value: String, action: String) {
        print("delegateINOfert")
    }
}
