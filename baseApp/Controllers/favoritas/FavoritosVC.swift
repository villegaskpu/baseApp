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
    var isRefresTableView = false
    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        BaseDelegate = self
        TableViewCellFactory.registerCells(tableView: tableView, types: .offertCell)
        tableItems.removeAll()
        addRefreshControl()
        getFAtovitos(page: page)
    }
    
    private func addRefreshControl() {
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Actializar Favoritos", attributes: [NSAttributedString.Key.font : UIFont.titleOferta])
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        page = 1
        isRefresTableView = true
        tableItems.removeAll()
        tableView.reloadData()
        getFAtovitos(page: page)
        isRefresTableView = false
    }
    
    
    
    
    func getFAtovitos(page: Int) {
        if !isRefresTableView {
            showLoading()
        }
        let requestFavorites = Requests.createFavoriteOffersRequest("", self.page, Constants.numberOfRowsPerPage, (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0)!, (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)!)
        
        let network = Network()
        print("request: \(requestFavorites)")
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: requestFavorites)
        network.endPointN(endPont: .GetFavoriteOffers) { (statusCode, value, objeto) -> (Void) in
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
                    self.refreshControl.endRefreshing()
                })
                self.hideLoading()
            } else {
                print("value: \(value)")
                self.hideLoading()
                
                self.tableItems.set(section: "Sin resultados")
                self.tableView.reloadData()
                UIView.animate(withDuration: 2.0, animations: {
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
extension FavoritosVC: BTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("seleccionado: \(indexPath.row)")

        let vc = detalleOfertaVC()
        vc.offertSelect = tableItems.getItem(section: indexPath.section, at: indexPath.row).offer
        self.navigationController?.fadeTo(vc)
        
    }
    
    func BTableView(tableItems: InfoManager, deleteCell indexPath: IndexPath) {
        tableItems.removeItem(section: indexPath.section, at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        if self.tableItems.count == 0{
            self.tableItems.set(section: "Sin favoritos")
        }
    }
}
