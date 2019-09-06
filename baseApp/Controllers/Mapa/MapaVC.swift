//
//  MapaVC.swift
//  baseApp
//
//  Created by David on 9/5/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import MapKit
import a4SysCoreIOS

class MapaVC: BViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedAnnotation : YopterAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        loadMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadMap()
    }
    
    func loadMap()
    {
        //CLLocation.init(latitude: 0, longitude: 0)
        if let cordinate = LocationUtil.sharedInstance.currentLocation?.coordinate {
            let coordinateRegion = MKCoordinateRegion(center: cordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.showsUserLocation = true
            let parametars = Requests.createSearchStoreRequest("", 1, 20, (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude)!, (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude)!, 2)
            self.getTiendas(parametars: parametars)
        }
        
    }
    
    
    func getTiendas(parametars: [String:Any]) {
        showLoading()
        let network = Network()
        network.setConstants(constants: constantsParameters)
        network.setEnvironment(Environment: ENVIROMENTAPP)
        network.setUrlParameters(urlParameters: parametars)
        
        network.endPointN(endPont: .StoresSearch) { (statusCode, value, objeto) -> (Void) in
            if StatusCode.validateStatusCode(code: statusCode.toInt() ?? 0) {
                //                print("value: \(value)")
                if let stores = objeto as? [Store] {
                    for item in stores
                    {
                        let annotation = YopterAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D.init(latitude: item.latitude, longitude: item.longitude)
                        annotation.title = item.commerce.name
                        annotation.subtitle = item.offers.count > 1 ? "\(item.offers.count) ofertas" : "\(item.offers.count) oferta"
                        annotation.store = item
                        self.mapView.addAnnotation(annotation)
                    }
                } else {
                    Commons.showMessage("GLOBAL_ERROR".localized)
                }
                self.hideLoading()
            } else {
                print("value error: \(value)")
                self.hideLoading()
                if let val = objeto as? ApiError {
                    Commons.showMessage("\(val.message)", duration: TTGSnackbarDuration.long)
                } else {
                    Commons.showMessage("GLOBAL_ERROR".localized)
                }
            }
        }
    }
}
// MARK: MAP VIEW DELEGATE
extension MapaVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            (annotation as! MKUserLocation).title = "Mi ubicación"
            return nil
        }
        
        let myIdentifier = "myIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: myIdentifier)
        let ann = annotation as! YopterAnnotation
        var imgSizeURL : String = ""
        //        if ann.store?.commerce?.s3LogoURL != nil && ann.store?.commerce?.s3LogoURL != ""
        //        {
        //            imgSizeURL = (ann.store?.commerce?.s3LogoURL.replacingOccurrences(of: "{1}", with: "30").replacingOccurrences(of: "{2}", with: "full"))!
        //        }
        //        else
        //        {
        imgSizeURL = String(format: "https://process.filepicker.io/AH7460UhS4uWVDAJg6VBgz/resize=width:30/%@", (ann.store?.commerce.logoURL)!)
        //        }
        
        if annotationView == nil
        {
            annotationView = MKAnnotationView.init(annotation: ann, reuseIdentifier: myIdentifier)
            
            let detailButton = UIButton.init(type: .custom)
            detailButton.frame =  CGRect.init(x: 0, y: 0, width: 50, height: 50)
            detailButton.setTitle("Ver ofertas", for: .normal)
            detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 8)
            detailButton.backgroundColor = UIColor.init(red: 31/255, green: 53/255, blue: 94/255, alpha: 1.0)
            detailButton.addTarget(self, action: #selector(handleSeeOffersButton(_:)), for: .touchUpInside)
            annotationView?.centerOffset = CGPoint.init(x: 0, y: 0)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = detailButton
            //            annotationView.setImageWithURL(urlString: imgSizeURL)
        }
        else
        {
            annotationView?.annotation = annotation
            if !Settings.sharedInstance.getIsMap()!
            {
                annotationView?.rightCalloutAccessoryView = nil
            }
        }
        
        annotationView?.setImageWithURL(urlString: imgSizeURL)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if !(view.annotation?.isKind(of: MKUserLocation.self))!
        {
            self.selectedAnnotation = (view.annotation as! YopterAnnotation)
            var zoomRect = MKMapRect.null
            
            let annotationPoint = MKMapPoint((view.annotation?.coordinate)!)
            let pointRect = MKMapRect(x: annotationPoint.x - 2500.0, y: annotationPoint.y - 2500.0, width: 5000.0, height: 5000.0)
            zoomRect = zoomRect.union(pointRect)
            mapView.setVisibleMapRect(zoomRect, animated: true)
        }
        else
        {
            mapView.userLocation.title = "Mi ubicación"
            (view.annotation as! MKUserLocation).title = "Mi ubicación"
        }
    }
    
    @IBAction func centerInUserLocation(_ sender: Any) {
        let location = self.mapView.userLocation.location
        if location != nil
        {
            self.mapView.centerCoordinate = (location?.coordinate)!
        }
    }
    
    @IBAction func updateOffers(_ sender: Any) {
        let coordinateRegion = MKCoordinateRegion(center: self.mapView.centerCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        self.mapView.setRegion(coordinateRegion, animated: true)
        let requestOffers = Requests.createSearchStoreRequest("", 1, 20, self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude, 2)
        self.getTiendas(parametars: requestOffers)
    }
}
extension MapaVC {
    @objc func handleSeeOffersButton(_ btn: UIButton)
    {
        var arrOffers = [Int]()
        
        for item in (self.selectedAnnotation?.store?.offers)!
        {
            arrOffers.append(item.idOffer)
        }
        
        self.tabBarController?.selectedIndex = 0
        let requestOffers = ["search" : ["value": "", "offers" : arrOffers], "context" : ["location" : ["latitude" : (LocationUtil.sharedInstance.currentLocation?.coordinate.latitude)!, "longitude" : (LocationUtil.sharedInstance.currentLocation?.coordinate.longitude)!]]] as [String : Any]
        NotificationCenter.default.post(name: .offerFromMapNotificationName, object: self, userInfo: requestOffers)
    }
}
