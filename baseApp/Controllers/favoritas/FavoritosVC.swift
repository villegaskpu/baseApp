//
//  FavoritosVC.swift
//  baseApp
//
//  Created by David on 8/27/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

class FavoritosVC: BTableViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        TableViewCellFactory.registerCells(tableView: tableView, types: .offertCell)
        tableItems.removeAll()
        getFAtovitos(page: page)
    }
    
    func getFAtovitos(page: Int) {
        showLoading()
        let requestFavorites = Requests.createFavoriteOffersRequest("", self.page, Constants.numberOfRowsPerPage, (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0)!, (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)!)
        
        let network = Network()
        print("request: \(requestFavorites)")
        network.setUrlParameters(urlParameters: requestFavorites)
        network.endPointN(endPont: .GetFavoriteArticles) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                //                print("value: \(value)")
                var obj = objeto as! [Offer]
                if obj.count > 0 {
                    obj = obj.map({ (offert: Offer) -> Offer in
                        let mutable = offert
                        mutable.isHome = false
                        mutable.isFavorite = true
                        return mutable
                    })
                    
                    
                    self.tableItems.set(section: "")
                    for a in obj {
                        let ofert = InfoItem(identifier: "favoritos", type: .offertCell, title: "", value: "")
                        ofert.offer = a
                        self.tableItems.append(item: ofert)
                    }
                    
                }
                else if obj.count == 0 && self.tableItems.count > 0{
                    Commons.showMessage("No hay mas resultados para mostrar")
                }
                else {
                    self.tableItems.set(section: "Aún no tienes ofertas favoritas")
                }
                
                self.tableView.reloadData()
                UIView.animate(withDuration: 2.0, animations: {
                    self.tableView.alpha = 1
                })
                self.hideLoading()
            } else {
                print("value: \(value)")
                self.hideLoading()
                
                self.tableItems.set(section: "Sin resultados")
                self.tableView.reloadData()
                UIView.animate(withDuration: 2.0, animations: {
                    self.tableView.alpha = 1
                })
                
                let val = objeto as! ApiError
                Commons.showMessage("\(val.message)", duration: TTGSnackbarDuration.long)
            }
        }
    }
}
extension FavoritosVC: BTableViewDelegate {
    func BTableView(tableItems: InfoManager, deleteCell indexPath: IndexPath) {
        tableItems.removeItem(section: indexPath.section, at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
