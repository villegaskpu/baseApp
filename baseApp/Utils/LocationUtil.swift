//
//  LocationUtil.swift
//  Yopter
//
//  Created by Victor Hernandez on 5/31/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import ObjectMapper
import a4SysCoreIOS

protocol LocationUtilDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}

class LocationUtil : NSObject, CLLocationManagerDelegate
{
    static let sharedInstance = LocationUtil()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationUtilDelegate?
    var isInBackground = false
    var isInMall = false
    var isCallingService = false
    var geofencesUpdated = false
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    
    private override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func startMonitoringSingnificantLocationChanges()
    {
        self.isInBackground = true
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges()
    {
        self.isInBackground = false
        self.locationManager?.stopMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager?.stopUpdatingLocation()
        
        guard let location = locations.last else {
            return
        }
        let locationAge = location.timestamp.timeIntervalSinceNow
        print("Time interval: \(locationAge)")
        
        // singleton for get last(current) location
        self.currentLocation = location
        
        // use for real time update location
        updateLocation(currentLocation: location)
        
        if !self.geofencesUpdated
        {
//            updateGeofences(location){ geofences in
//                print("Actualice las geocercass")
//                Settings.sharedInstance.setGeofenceDate(value: Commons.getCurrentDateForSupport())
//                if geofences != nil
//                {
//                    if (geofences?.count)! > 0
//                    {
//                        self.removeAllGeofences()
//                        var counter = 0
//                        for item in geofences!
//                        {
//                            if counter < 20
//                            {
//                                self.locationManager?.startMonitoring(for: self.addGeofences(geofence: item))
//                                counter = counter + 1
//                            }
//                        }
//                        self.geofencesUpdated = true
//                    }
//                }
//            }
            
            if startLocation == nil { // solo se ejecuta una vez
//                startLocation = locations.first
                Settings.sharedInstance.setLatitude(value: "\(location.coordinate.latitude)")
                Settings.sharedInstance.setLongitude(value: "\(location.coordinate.longitude)")
                if UIApplication.shared.applicationState == .background || UIApplication.shared.applicationState == .inactive{
                    print("SEGUNDOPLANOnil")
                    Commons.heardBeat()
                }
            } else {
                let ubicacionGuardada = CLLocation(latitude: Settings.sharedInstance.getLatitude()?.toDouble() ?? 0.0, longitude: Settings.sharedInstance.getLongitude()?.toDouble() ?? 0.0)
                let mts = ubicacionGuardada.distance(from: locations.first!)
                
                print("mts: \(mts)")
                if mts >= 100 {
                    Settings.sharedInstance.setLatitude(value: "\(location.coordinate.latitude)")
                    Settings.sharedInstance.setLongitude(value: "\(location.coordinate.longitude)")
                    if UIApplication.shared.applicationState == .background || UIApplication.shared.applicationState == .inactive{
                        print("SEGUNDOPLANO")
                        Commons.heardBeat()
                    }
                }
            }
        }
        
        
        //Fix Geolocalitation, Geocercas
        
        // self.checkMall()
    }
    
    func removeAllGeofences()
    {
//        if self.locationManager?.monitoredRegions != nil
//        {
//            for region in (self.locationManager?.monitoredRegions)!
//            {
//                self.locationManager?.stopMonitoring(for: region)
//            }
//        }
    }
    
//    func addGeofences(geofence : Geofence) -> CLCircularRegion
//    {
//        let coordinate = CLLocationCoordinate2D.init(latitude: (geofence.location.latitude), longitude: (geofence.location.longitude))
//
//        let region = CLCircularRegion.init(center: coordinate, radius: geofence.radio, identifier: geofence.name)
//        region.notifyOnEntry = true
//        region.notifyOnExit = true
//        return region
//    }
//
//    func showNotification(title: String, message: String, identifier: String) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = message
//        content.sound = UNNotificationSound.default
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//        locationManager?.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside
        {
            if let circularRegion = (region as? CLCircularRegion)
            {
                let params : [String : Any] = ["latitude" : "\(circularRegion.center.latitude)", "longitude" : "\(circularRegion.center.longitude)"]
                
//                sessionManager.request(YopterRouter.WhoAmI(parameter: params)).responseArray{
//                    (response: DataResponse<[WhoAmI]>?) in
//                    if response?.result.error == nil {
//                        if (response?.value?.count)! > 0{
//                            for value in (response?.value)! {
//                                print("Valor vacio")
//                                self.showNotification(title: Constants.appName, message: value.message!, identifier: value.name!)
//                            }
//                        }
//                    }
//                }
            }
            /*else
             {
                self.showNotification(title: Constants.appName, message: "No puede notificar", identifier: "Test")
            }*/
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        if let circularRegion = (region as? CLCircularRegion)
        {
            
//            let params : [String : Any] = ["latitude" : "\(circularRegion.center.latitude)", "longitude" : "\(circularRegion.center.longitude)"]
//            sessionManager.request(YopterRouter.WhoAmI(parameter: params)).responseArray{
//                (response: DataResponse<[WhoAmI]>?) in
//                if response?.result.error == nil {
//                    if (response?.value?.count)! > 0{
//                        for value in (response?.value)! {
//                            self.showNotification(title: Constants.appName, message: value.message!, identifier: value.name!)
//                        }
//                    }
//                }
//            }
        }
        /*else
         {
            self.showNotification(title: Constants.appName, message: "No puede notificar", identifier: "Test")
        }*/
    }
    
    func updateGeofences(_ location: CLLocation, completion: @escaping([Geofence]?) -> ())
    {
        self.geofencesUpdated = true

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        self.currentLocation = currentLocation
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
}


