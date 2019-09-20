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
import a4SysCoreIOS

class TemporalHome: BViewController {

    var primeraVez = true
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        LocationUtil.sharedInstance.delegate = self
        LocationUtil.sharedInstance.startUpdatingLocation()
        self.navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        cargandoItem(self, message: "Buscando Ofertas cerca de ti...", activity: true)
        getConfigurationTheme()
    }
    
    
    func getConfigurationTheme() {
        let requestTheme = Requests.createThemeRequest(valor: Settings.sharedInstance.getDateRefreshTheme())
        
        let network = Network()
        network.setUrlParameters(urlParameters: requestTheme)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setConstants(constants: constantsParameters)
        
        network.endPointN(endPont: .GetTheme) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                if let confi = objeto as?  Configurations {
                    if confi.refresh == 1 {
//                        Settings.sharedInstance.setTopColor(value: confi.customColors.header)
//                        Settings.sharedInstance.setbackground(value: confi.customColors.background)
//                        Settings.sharedInstance.setBottomColor(value: confi.customColors.footer)
//                        Settings.sharedInstance.setTitleBackgroundColor(value: confi.customColors.titleBackground)
                        
//                        let theme = CustomTheme()
//                        theme.apply(for: UIApplication.shared)
//                        self.descargarImagen(url: value.images.headerURL)
                        Settings.sharedInstance.setDateRefreshTheme(value: Commons.getCurrentDate())
                        Settings.sharedInstance.setThemeCustom(value: "1")
                        Settings.sharedInstance.setMenu(value: confi.menu.toJSON())
                    }
                } else {
                    print("fallo parser thema")
                }
            } else {
                print("fallo  thema")
            }
        }
    }
    
    
    
    
}
extension TemporalHome: LocationUtilDelegate {
    func tracingLocation(currentLocation: CLLocation) {
        print("QUEDO")
        if primeraVez {
            LocationUtil.sharedInstance.currentLocation = currentLocation
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.removeLoading()
                self.navigationController?.isNavigationBarHidden = false
                let vc = principalTabBarVC()
                self.navigationController?.fadeTo(vc)
            }
            timerHearBeats.invalidate()
            Commons.heardBeat()
            timerHearBeats = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            primeraVez = false
        }
    }
    
    @objc func timerAction() {
        print("solo soy un print")
        Commons.heardBeat()
    }
    
    func tracingLocationDidFailWithError(error: Error) {
        print("no QUEDO")
        hideLoading()
        LocationUtil.sharedInstance.currentLocation = CLLocation.init(latitude: 0, longitude: 0)
    }
    
    
}
// Mark- descargar imagen
extension TemporalHome {
    
    func descargarImagen(url:String) {
        Commons.createDirectory()
        if let url = URL(string: url) {
            self.downloadImage(from: url)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        
//        Alamofire.request(url).responseImage { response in
//            debugPrint(response)
//            
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//            
//            if let image = response.result.value {
//                Commons.saveImageDocumentDirectory(image: image, imageName: self.nameImage)
//                UIView.animate(withDuration: 2.0, animations: {
//                    
//                    DispatchQueue.main.async {
//                        self.imageLogo.image = Commons.setImageLogo()
//                    }
//                })
//            }
//        }
    }
    
    
}

