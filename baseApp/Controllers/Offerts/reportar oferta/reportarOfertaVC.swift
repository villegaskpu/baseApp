//
//  reportarOfertaVC.swift
//  baseApp
//
//  Created by David on 9/12/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import DropDown
import a4SysCoreIOS

class reportarOfertaVC: BViewController {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var txtComentario: UITextView!
    @IBOutlet weak var lMotivo: UILabel!
    @IBOutlet weak var lReportarOferta: UILabel!
    @IBOutlet weak var lComentario: UILabel!
    @IBOutlet weak var lSucursal: UILabel!
    @IBOutlet weak var btnMotivoO: UIButton!
    @IBOutlet weak var btnSucursalO: UIButton!
    
    
    
    var offertSelec:Offer?
    
    
    let dropDown = DropDown()
    
    var arrayMotivos : [ReportReason] = []
    var selectMotivo : ReportReason?
    
    var sucursalArray : [Store] = []
    var selectedSucursal : Store?
    
    let dropDownSucursal = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setlistaDesplegable()
        showLoading()
        setStyles()
        getMotivo()
        getSucursal()
    }
    
    private func setStyles() {
        viewContent.backgroundColor = UIColor.lightGray
        
        lReportarOferta.font = UIFont.titulosModales
        lReportarOferta.textColor = UIColor.battleshipGrey
        
        lComentario.font = UIFont.labelWhite
        lComentario.textColor = UIColor.black
        
        lSucursal.font = UIFont.labelWhite
        lSucursal.textColor = UIColor.black
        
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = setTitleview()
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), landscapeImagePhone: #imageLiteral(resourceName: "backArrow"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtn))
        menuButton.tintColor = #colorLiteral(red: 0.7780508399, green: 0.8403770328, blue: 0.9060906768, alpha: 1)
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func backBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setlistaDesplegable() {
        self.dropDown.anchorView = btnMotivoO
        self.dropDownSucursal.anchorView = btnSucursalO
    }
    
    private func getMotivo() {
        
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: [:])
        
        network.endPointN(endPont: .GetReportReason) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let a = objeto as? [ReportReason] {
                    self.arrayMotivos = a
                    self.loadReasonDropdown()
                } else {
                    print("fallo cast")
                }
            } else {
                
            }
            self.hideLoading()
        }
    }
    
    func loadReasonDropdown()
    {
        let dataSourceReason = self.arrayMotivos.map(){ $0.name }
        self.dropDown.dataSource = dataSourceReason
        self.dropDown.selectionAction = { (index: Int, item: String) in
            self.btnMotivoO.setTitle(item, for: .normal)
            self.selectMotivo = self.arrayMotivos[index]
        }
        self.dropDown.direction = .top
    }
    
    
    //MARK: sucursales
    func getSucursal() {
        showLoading()
        if let currentStores = self.offertSelec?.commerce.stores {
            self.sucursalArray = Array(currentStores)
        }
        let requestMoreStores = Requests.createGetStoresRequest(LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0)
        
        
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: requestMoreStores)
        network.setIdOffert(idOfert: "\(self.offertSelec?.idOffer ?? 0)")
        
        network.endPointN(endPont: .GetStores) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let stroes = objeto as? [Store] {
                    self.sucursalArray += stroes
                    self.loadSucursal()
                } else {
                    print("fallo cast")
                }
            } else {
                print("no valido")
            }
            self.hideLoading()
        }
    }
    
    
    func loadSucursal()
    {
        let dataSourceSucursal = self.sucursalArray.map(){ $0.name }
        self.dropDownSucursal.dataSource = dataSourceSucursal 
        self.dropDownSucursal.selectionAction = { (index: Int, item: String) in
            self.btnSucursalO.setTitle(item, for: .normal)
            self.selectedSucursal = self.sucursalArray[index]
        }
        self.dropDownSucursal.direction = .top
    }
    
    func validateForm() -> Bool
    {
        if self.txtComentario.text == nil || self.txtComentario.text == ""
        {
            Commons.showMessage("NO_COMMENT".localized)
            return false
        }
        
        else if self.dropDown.selectedItem == nil || self.dropDown.selectedItem == ""
        {
            Commons.showMessage("NO_REPORT_REASON".localized)
            return false
        }
        else if self.dropDownSucursal.selectedItem == nil || self.dropDownSucursal.selectedItem == ""
        {
            Commons.showMessage("NO_SUCURSAL".localized)
            return false
        }
        return true
    }
    
    
    
    @IBAction func btnCerrarAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnMotivoAction(_ sender: Any) {
         self.dropDown.show()
    }
    
    
    
    @IBAction func btnSucursalAction(_ sender: Any) {
        self.dropDownSucursal.show()
    }
    
    
    @IBAction func btnSiEstoySeguroAction(_ sender: Any) {
        if validateForm() {
            showLoading()
            let requestReportOffer = Requests.createReportOfferRequest("\(self.selectMotivo?.idReportReason ?? 1)", self.txtComentario.text, LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0.0, LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0.0, (self.selectedSucursal?.idStore ?? 1)!)
            
            let network = Network()
            network.setConstants(constants: constantsParameters)
            network.setEnvironment(Environment: ENVIROMENTAPP)
            network.setIdOffert(idOfert: "\(self.offertSelec?.idOffer ?? 0)")
            network.setUrlParameters(urlParameters: requestReportOffer)
            network.endPointN(endPont: .ReportOffer) { (statusCode, value, objeto) -> (Void) in
                if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                    self.hideLoading()
                    self.dismiss(animated: true, completion: {
                        self.showLoading()
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
                        self.hideLoading()
                        let vc = ofertaReportadaVC()
                        self.present(vc, animated: true, completion: nil)
                        self.navigationController?.fadeTo(vc)
                    })
                } else {
                    print("invalida")
                }
            }
        }
    }
    
//    override func dismiss(animated flag: Bool, completion: (() -> Void)?)
//    {
//        if self.presentedViewController != nil {
//            super.dismiss(animated: flag, completion: completion)
//        }
//    }
}
