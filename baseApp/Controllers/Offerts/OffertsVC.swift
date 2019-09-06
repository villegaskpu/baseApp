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
    
    @IBOutlet weak var lTitulo: UILabel!
    
    @IBOutlet weak var lViewTitulo: UIView!
    
    
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
        NotificationCenter.default.setObserver(self, selector: #selector(self.openFromMap(_:)), name: .offerFromMapNotificationName, object: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = true
        setStyle()
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .offertCell)
        
        tableItems.removeAll()
        
        let param = Requests.createHomeRequest("", pageHome, Constants.numberOfRowsPerPage, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)
        
        getHome(parameters: param)
    }
    
    private func setStyle() {
        lTitulo.text = "OFERTAS"
        lTitulo.textColor = UIColor.black
        lTitulo.font = UIFont.titulosInterior
        lTitulo.textColor = UIColor.black
        
        // vista debajo del titulo
        lViewTitulo.backgroundColor = UIColor.lightGreyBlue
    }
    
    
    @objc func openFromMap(_ notification: Notification)
    {
        self.pageOferts = 1
        tableItems.removeAll()
        tableView.reloadData()
        Settings.sharedInstance.setSaved(value: false)
        Settings.sharedInstance.setFilter(value: false)
        Settings.sharedInstance.setSearch(value: true)
        self.getOferts(parameters: notification.userInfo as! [String : Any])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .offerFromMapNotificationName, object: nil)
    }
    
    func getHome(parameters: [String:Any]) {
        var parametersO:[String:Any] = [:]
        
        
        if parameters.isEmpty {
            parametersO = Requests.createHomeRequest("", Constants.numberOfRowsPerPage, pageHome, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
        } else{
            parametersO = parameters
        }
        
        
        let network = Network()
        network.setUrlParameters(urlParameters: parametersO)
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.endPointN(endPont: .GetHome) { (statusCode, value, objeto) -> (Void) in
            
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                print("getOferts")
                if let oferts = objeto as? [Offer] {
                    self.tableItems.set(section: "")
                    for a in oferts {
                        //                    print("oddfddd: \(a.title)")
                        let ofert = InfoItem(identifier: "homeOfertas", type: .offertCell, title: "", value: "")
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
                
                
                let parameters = Requests.createSearchOfferRequest("", self.pageOferts, Constants.numberOfRowsPerPage, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)
                self.getOferts(parameters: parameters)
                
                self.hideLoading()
            } else {
                let parameters = Requests.createSearchOfferRequest("", self.pageOferts, Constants.numberOfRowsPerPage, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)
                self.getOferts(parameters: parameters)
//                if let val = objeto as? ApiError {
//                    Commons.showMessage("\(val.message)", duration: TTGSnackbarDuration.long)
//                } else {
//                    Commons.showMessage("GLOBAL_ERROR".localized)
//                }
            }
        }
    }
    
    func getOferts(isFilter:Bool = false, parameters: [String:Any]) {
        
        let network = Network()
        
        network.setConstants(constants: constantsParameters)
        network.setUrlParameters(urlParameters: parameters)
        network.endPointN(endPont: .OfferSearch) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                print("getOferts")
                if let oferts = objeto as? [Offer] {
                    self.tableItems.set(section: "")
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
extension OffertsVC: BTableViewDelegate {
    func BTableView(tableItems: InfoManager, updateCell indexPath: IndexPath, value: String, action: String) {
        print("delegateINOfert")
    }
}

extension OffertsVC: principalTabBarVCDelegate {
    func setParameters(parametares: [String : Any]) {
        print("estamosDentro")
    }
    

}
