//
//  OffertsVC.swift
//  baseApp
//
//  Created by David on 8/22/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS
import SearchTextField

class OffertsVC: BTableViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lTitulo: UILabel!
    @IBOutlet weak var lViewTitulo: UIView!
    
    
    @IBOutlet weak var textSearchControl: SearchTextField!
    @IBOutlet weak var iconSearchControl: UIImageView!
    @IBOutlet weak var constraintHSearchControl: NSLayoutConstraint!
    
    @IBOutlet weak var constraintTopSearchControl: NSLayoutConstraint!
    
    
    @IBOutlet weak var constraintTopOfertTitulo: NSLayoutConstraint!
    
    var items = InfoManager()
    
    var pageHome = 1
    var pageOferts = 1
    var isShowSearchControl = false
    
    var delegate: principalTabBarVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        tableView.alpha = 0
        self.textSearchControl.delegate = self
        iconSearchControl.isHidden = true
        constraintHSearchControl.constant = 0
        constraintTopSearchControl.constant = 0
        constraintTopOfertTitulo.constant = 80
        print("hola ofertas")
        BaseDelegate = self
        self.delegate = principalTabBarVCDelegate.self as? principalTabBarVCDelegate
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.setObserver(self, selector: #selector(self.openFromMap(_:)), name: .offerFromMapNotificationName, object: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = true
        setStyle()
        addRefreshControl()
        TableViewCellFactory.registerCells(tableView: tableView, types: .offertCell)
        setInitialHome()
        setSearchControl()
    }
    
    private func setSearchControl() {
        self.textSearchControl.comparisonOptions = [.caseInsensitive]
        self.textSearchControl.maxNumberOfResults = 5
        self.textSearchControl.theme.bgColor = UIColor.white
        self.textSearchControl.theme.font = UIFont.systemFont(ofSize: 16)
        
        
        self.textSearchControl.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.textSearchControl.text = item.title
            self.pageOferts = 1
            let requestSearchOffers = Requests.createSearchOfferRequest(self.textSearchControl.text!, self.pageOferts, Constants.numberOfRowsPerPage, (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude)!, (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude)!)
            
            self.showLoading()
            self.tableItems.removeAll()
            self.tableView.reloadData()
            self.getOferts(parameters: requestSearchOffers)
//            self.showSearchControl()
            self.showHiddeSearchControl(ocultar: !self.isShowSearchControl)
            self.textSearchControl.resignFirstResponder()
            
        }
        
        self.textSearchControl.userStoppedTypingHandler = {
            if let criteria = self.textSearchControl.text{
                if criteria.count > 1
                {
                    self.textSearchControl.showLoadingIndicator()
                    
                    let network = Network()
                    network.setEnvironment(Environment: ENVIROMENTAPP)
                    network.setConstants(constants: constantsParameters)
                    network.setUrlParameters(urlParameters: [:])
                    network.setTerminoAbuscar(criteria)
                    
                    network.endPointN(endPont: .Suggest, { (statusCode, value, objeto) -> (Void) in
                        if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                            
                            
                            
                            
                            if let a = value as? [String] {
                                var results = [SearchTextFieldItem]()
                                
                                for item in a {
                                    results.append(SearchTextFieldItem.init(title: item))
                                }
                                self.textSearchControl.filterItems(results)
                                self.textSearchControl.stopLoadingIndicator()
                                print(a)
                            }
                        } else {
                            print("fallo la busqueda")
                        }
                    })
                }
            }
        }
    }
    
    private func setInitialHome() {
        tableView.alpha = 0
        tableItems.removeAll()
        let param = Requests.createHomeRequest("", pageHome, Constants.numberOfRowsPerPage, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)
    
        getHome(parameters: param)
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
        refreshControl.attributedTitle = NSAttributedString(string: "Actializar Ofertas", attributes: [NSAttributedString.Key.font : UIFont.titleOferta])
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        pageHome = 1
        pageOferts = 1
        tableItems.removeAll()
        tableView.reloadData()
        isShowSearchControl = false
        self.showHiddeSearchControl(ocultar: false)
        setInitialHome()
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
//                    Commons.showMessage("GLOBAL_ERROR".localized)
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
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.endPointN(endPont: isFilter ? .OfferSearchFilter : .OfferSearch) { (statusCode, value, objeto) -> (Void) in
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
                    UIView.animate(withDuration: 1.0, animations: {
                        self.tableView.alpha = 1
                        self.refreshControl.endRefreshing()
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
extension OffertsVC: BTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("seleccionado: \(indexPath.row)")
        
        
        let vc = detalleOfertaVC()
        vc.offertSelect = tableItems.getItem(section: indexPath.section, at: indexPath.row).offer
        self.navigationController?.fadeTo(vc)
        
    }
    
    func BTableView(tableItems: InfoManager, updateCell indexPath: IndexPath, value: String, action: String) {
        print("delegateINOfert")
        
        self.tableItems.getItem(section: indexPath.section, at: indexPath.row).offer.favorite = value.toInt() ?? 0
        
        if action == "favorite" {
            self.tableItems.getItem(section: indexPath.section, at: indexPath.row).offer.favorite = value.toInt() ?? 0
        }
        else if action == "likes" {
            self.tableItems.getItem(section: indexPath.section, at: indexPath.row).offer.userRating.rating = value.toDouble() ?? Double(0)
        }
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func BTableView(tableItems: InfoManager, deleteCell indexPath: IndexPath) {
        tableItems.removeItem(section: indexPath.section, at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        if self.tableItems.count == 0{
            self.tableItems.set(section: "Sin Ofertas")
        }
    }
}

// MARK: TEXTFIELD DELEGATE METHODS
extension OffertsVC: principalTabBarVCDelegate {
    func aplicarFiltros(idFiltro: String) {
        print("filtro ya en ofertas")
        self.pageOferts = 1
        tableItems.removeAll()
        tableView.reloadData()
        let requestSearchOffers = Requests.createSearchOfferByCategoryRequest(idFiltro.toInt() ?? 0, self.pageOferts, Constants.numberOfRowsPerPage, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)
        showLoading()
        self.getOferts(isFilter: true, parameters: requestSearchOffers)
    }
    
    func btnSearchPress() {
        self.showHiddeSearchControl(ocultar:!isShowSearchControl)
        isShowSearchControl = !isShowSearchControl
    }
    
    private func showHiddeSearchControl(ocultar:Bool) {
        UIView.animate(withDuration: 1.5) {
            self.iconSearchControl.isHidden = ocultar ? false : true
            self.constraintHSearchControl.constant = ocultar ? 60 : 0
            self.constraintTopSearchControl.constant = ocultar ? 60 : 0
            self.constraintTopOfertTitulo.constant = ocultar ? 0 : 80
        }
    }
}

extension OffertsVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pageOferts = 1
        let requestSearchOffers = Requests.createSearchOfferRequest(self.textSearchControl.text!, self.pageOferts, Constants.numberOfRowsPerPage, (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude)!, (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude)!)
        tableItems.removeAll()
        tableView.reloadData()
        self.getOferts(parameters: requestSearchOffers)
        self.textSearchControl.text = ""
        self.showHiddeSearchControl(ocultar:false)
        self.textSearchControl.resignFirstResponder()
        return false
    }
}
