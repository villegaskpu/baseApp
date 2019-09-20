
//
//  FiltrosVC.swift
//  baseApp
//
//  Created by David on 9/5/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import a4SysCoreIOS

protocol FiltrosVCDelegate {
    func returnFiltros(menuFiltro:String)
}

class FiltrosVC: BViewController {
    
    @IBOutlet weak var LTitulo: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lViewTitulo: UIView!
    
    var filtros:[FiltersCategories] = []
    var delegate:FiltrosVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "filtrosCell", bundle: nil), forCellWithReuseIdentifier: "filtrosCell")
        
        setStyle()
        getCategorias()
    }
    
    private func setStyle() {
        LTitulo.text = "FILTROS"
        LTitulo.textColor = UIColor.black
        LTitulo.font = UIFont.titulosInterior
        LTitulo.textColor = UIColor.black
        
        // vista debajo del titulo
        lViewTitulo.backgroundColor = UIColor.lightGreyBlue
    }
    
    
    private func getCategorias() {
        self.collectionView.alpha = 0
        self.filtros.removeAll()
        showLoading()
        
        let network = Network()
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setConstants(constants: constantsParameters)
        network.endPointN(endPont: .GetFilters) { (statusCode, value, objeto) -> (Void) in
            let statusC = statusCode.toInt() ?? 0
            
            if statusC >= 200 && statusC < 300 {
                print("ya estufas: \(value)")
                if let obj = objeto as? [FiltersCategories] { // no se forsa el cast para evitar que truene el app
                    self.filtros = obj
                    self.collectionView.reloadData()
                    UIView.animate(withDuration: 1, animations: {
                        self.collectionView.alpha = 1
                    })
                } else {
                    Commons.showMessage("Error de comunicación")
                }
                self.hideLoading()
            }else {
                if let obj = objeto as? ApiError {
                    if obj.code == "500" {
                        Commons.showMessage("GLOBAL_ERROR".localized, duration: .long)
                    } else {
                        Commons.showMessage("\(obj.message)", duration: .long)
                    }
                } else {
                    Commons.showMessage("Error de comunicación")
                }
            }
            self.hideLoading()
        }
    }
}

extension FiltrosVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        Commons.activarTabBar(vc: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filtrosCell", for: indexPath) as! filtrosCell
//        cell.contentView.backgroundColor = Settings.sharedInstance.getBackgroundColor().withAlphaComponent(0.5)
        cell.contentView.backgroundColor = UIColor.lightGreyBlue
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.image.sd_setImage(with: URL.init(string: filtros[indexPath.row].iconUrl ?? ""), completed: nil)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) { // cuando presionas
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? filtrosCell {
                cell.image.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor.darkHotPink
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) { // cuando sueltas
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? filtrosCell {
                cell.image.transform = .identity
//                cell.contentView.backgroundColor = Settings.sharedInstance.getBackgroundColor().withAlphaComponent(0.5)
                cell.contentView.backgroundColor = UIColor.lightGreyBlue
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.tabBarController != nil
        {
            let menuOption = self.filtros[indexPath.row].idCategoryAlias
            delegate?.returnFiltros(menuFiltro: "\(menuOption ?? 0)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
}
