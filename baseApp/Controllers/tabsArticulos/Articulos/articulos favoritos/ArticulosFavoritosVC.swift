//
//  ArticulosFavoritosVC.swift
//  baseApp
//
//  Created by David on 9/19/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class ArticulosFavoritosVC: BTableViewController {
    
    @IBOutlet weak var lTituloArticulos: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        TableViewCellFactory.registerCells(tableView: tableView, types: .articulosCell)
        setStyle()
        getArticulosFavoritos()
    }
    
    private func setStyle() {
        lTituloArticulos.font = UIFont.titulosInterior
        lTituloArticulos.textColor = UIColor.black
    }
    
    
    private func getArticulosFavoritos() {
        showLoading()
        let params = ["search" : ["value" : "", "page" : 1, "rows" : 25]] as [String : Any]
        
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: params)
        
        network.endPointN(endPont: .GetFavoriteArticles) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                print("getArticulosFavoritos")
                if var articulos = objeto as? [Offer] {
                    
                    if articulos.count > 0 {
                        
                        articulos = articulos.map({ (offert: Offer) -> Offer in
                            let mutable = offert
                            mutable.isHome = false
                            mutable.isFavorite = true
                            mutable.isArticle = true
                            return mutable
                        })
                        
                        self.tableItems.set(section: "")
                        for a in articulos {
                            let ofert = InfoItem(identifier: "Ofertas", type: .articulosCell, title: "", value: "")
                            ofert.article = a
                            self.tableItems.append(item: ofert)
                        }
                        self.tableView.reloadData()
                        UIView.animate(withDuration: 1.0, animations: {
                            self.tableView.alpha = 1
                            self.refreshControl.endRefreshing()
                        })
                    }
                } else {
                    Commons.showMessage("GLOBAL_ERROR".localized)
                }
                self.hideLoading()
            } else {
                print("value error: \(value)")
                self.hideLoading()
                
                self.tableItems.set(section: "Sin resultados")
                self.tableView.reloadData()
                UIView.animate(withDuration: 1.0, animations: {
                    self.tableView.alpha = 1
                    self.refreshControl.endRefreshing()
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
