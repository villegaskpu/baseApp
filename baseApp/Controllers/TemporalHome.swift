//
//  TemporalHome.swift
//  baseApp
//
//  Created by David on 9/5/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import CoreLocation
import Lottie

class TemporalHome: BViewController {

    var primeraVez = true
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        LocationUtil.sharedInstance.delegate = self
        LocationUtil.sharedInstance.startUpdatingLocation()
        self.navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        cargandoItem(self, message: "Buscando Ofertas cerca de ti...", activity: true)
    }
}
extension TemporalHome: LocationUtilDelegate {
    func tracingLocation(currentLocation: CLLocation) {
        print("QUEDO")
        if primeraVez {
            LocationUtil.sharedInstance.currentLocation = currentLocation
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.removeLoading()
                let vc = principalTabBarVC()
                self.navigationController?.fadeTo(vc)
            }
            primeraVez = false
        }
    }
    
    func tracingLocationDidFailWithError(error: Error) {
        print("no QUEDO")
        hideLoading()
        LocationUtil.sharedInstance.currentLocation = CLLocation.init(latitude: 0, longitude: 0)
    }
    
    
}
