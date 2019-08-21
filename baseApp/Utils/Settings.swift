//
//  Settings.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


enum SettingsType: String {
    case userlogin = "userlogin"
}

class Settings
{
    static let sharedInstance = Settings()
    private let prefs = UserDefaults.standard
    private init(){}
    
    func setSesion(_ isSession:Bool) {
        prefs.set(isSession, forKey: SettingsType.userlogin.rawValue)
        prefs.synchronize()
    }
    
    func getSesion() -> Bool{
        return prefs.bool(forKey: SettingsType.userlogin.rawValue)
    }
    
    func getToken() -> String?
    {
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        if let token = prefs?.string(forKey: "token"){
            return token
        }
        else{
            return nil
        }
        
    }
    
    func setToken(value: String) -> Void{
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        prefs?.setValue(value, forKey: "token")
        prefs?.synchronize()
    }
    
    func getOldToken() -> String?
    {
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        if let token = prefs?.string(forKey: "oldToken"){
            return token
        }
        else{
            return nil
        }
        
    }
    
    func setOldToken(value: String) -> Void
    {
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        prefs?.setValue(value, forKey: "oldToken")
        prefs?.synchronize()
    }


    
    func getFilter() -> Bool?
    {
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: "filter")
    }
    
    func setIsFromMenu(value: Bool) -> Void{
        let prefs = UserDefaults.standard

        prefs.setValue(value, forKey: "isFromMenu")
        prefs.synchronize()
    }

    func getIsFromMenu() -> Bool?
    {
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: "isFromMenu")
    }
    
    func setFilter(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "filter")
        prefs.synchronize()
    }
    func setOnce(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "once")
        prefs.synchronize()
    }
    
    func getSearch() -> Bool?
    {
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: "search")
    }
    
    func setSearch(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "search")
        prefs.synchronize()
    }

    
    func getAnonymous() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let token = prefs.string(forKey: "anonymous"){
            return token
        }
        else{
            return nil
        }
        
    }
    
    func setAnonymous(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "anonymous")
        prefs.synchronize()
    }

    func getStartsFromKilled() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let token = prefs.string(forKey: "startsFromKilled"){
            return token
        }
        else{
            return nil
        }
        
    }
    
    func setStartsFromKilled(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "startsFromKilled")
        prefs.synchronize()
    }

    func getUsername() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let username = prefs.string(forKey: "username"){
            return username
        }
        else{
            return nil
        }
    }
    
    func setUsername(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "username")
        prefs.synchronize()
    }
    
    func getGeofenceDate() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let username = prefs.string(forKey: "geofenceDate"){
            return username
        }
        else{
            return nil
        }
    }
    
    func setGeofenceDate(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "geofenceDate")
        prefs.synchronize()
    }
    
    func getAccessToken() -> String?
    {
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        if let accesstoken = prefs?.string(forKey: "accesstoken"){
            return accesstoken
        }
        else{
            return nil
        }
    }
    
    func setAccessToken(value: String) -> Void{
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        prefs?.setValue(value, forKey: "accesstoken")
        prefs?.synchronize()
    }
    
    func getPassword() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let username = prefs.string(forKey: "password"){
            return username
        }
        else{
            return nil
        }
    }
    
    func setPassword(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "password")
        prefs.synchronize()
    }
    
    func getDeviceId() -> String?
    {
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        if let deviceId = prefs?.string(forKey: "deviceId"){
            return deviceId
        }
        else{
            return nil
        }
    }
    
    func setDeviceId(value: String) -> Void{
        let prefs = UserDefaults.init(suiteName: "group.comunica.app")
        
        prefs?.setValue(value, forKey: "deviceId")
        prefs?.synchronize()
    }
    
    func getSaved() -> Bool?
    {
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: "saved")
    }
    
    func setIsMap(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "isMap")
        prefs.synchronize()
    }
    
    func getIsMap() -> Bool?
    {
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: "isMap")
    }
    
    func setSaved(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "saved")
        prefs.synchronize()
    }
    
    func getLongitude() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let longitude = prefs.string(forKey: "longitude"){
            return longitude
        }
        else{
            return nil
        }
    }
    
    func setLongitude(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "longitude")
        prefs.synchronize()
    }
    
    func getLatitude() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let latitude = prefs.string(forKey: "latitude"){
            return latitude
        }
        else{
            return nil
        }
    }
    
    func setLatitude(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "latitude")
        prefs.synchronize()
    }
    
    func getColor() -> String?
    {
        let prefs = UserDefaults.standard
        
        if let latitude = prefs.string(forKey: "color"){
            return latitude
        }
        else{
            return ""
        }
    }
    
    func setColor(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "color")
        prefs.synchronize()
    }
    
    func setTopColor(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "topColor")
        prefs.synchronize()
    }
    
    func getTopColor() -> UIColor
    {
        let prefs = UserDefaults.standard
        
        if let color = prefs.string(forKey: "topColor"){
            return UIColor.hexStringToUIColor(hex: color)
        }
        else{
            return UIColor.blue
        }
    }
    
    func setBottomColor(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "bottomColor")
        prefs.synchronize()
    }
    
    func getBottomColor() -> UIColor
    {
        let prefs = UserDefaults.standard
        
        if let color = prefs.string(forKey: "bottomColor"){
            return UIColor.hexStringToUIColor(hex: color)
        }
        else{
            return UIColor.blue
        }
    }
    
    func setDateRefreshTheme(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "dateRefreshTheme")
        prefs.synchronize()
    }
    
    func getDateRefreshTheme() -> String
    {
        let prefs = UserDefaults.standard
        
        if let date = prefs.string(forKey: "dateRefreshTheme"){
            return date
        }
        else{
            return Commons.getCurrentDate(-5)
        }
    }
    
    func setThemeCustom() -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue("1", forKey: "themeCustom")
        prefs.synchronize()
    }
    
    func getThemeCustom() -> Bool
    {
        let prefs = UserDefaults.standard
        
        if let _ = prefs.string(forKey: "themeCustom"){
            return true
        }
        else{
            return false
        }
    }
    
    func setTitleBackgroundColor(value: String) -> Void{
        let prefs = UserDefaults.standard
        
        prefs.setValue(value, forKey: "titleBackgroundColor")
        prefs.synchronize()
    }
    
    func getTitleBackgroundColor() -> UIColor
    {
        let prefs = UserDefaults.standard
        
        if let color = prefs.string(forKey: "titleBackgroundColor"){
            return UIColor.hexStringToUIColor(hex: color)
        }
        else{
            return UIColor.blue
        }
    }
    
    
//    func setMenu(value: [Menu]) -> Void{
//        let prefs = UserDefaults.standard
//        prefs.set(value.toJSON(), forKey: "menuLeft")
//        prefs.synchronize()
//    }
//
//    func getMenu() -> [Menu]?
//    {
//        let prefs = UserDefaults.standard
//
//        if let menu = prefs.object(forKey: "menuLeft") as? [[String:Any]] {
//            // Convert JSON String to Model
//            //let user = Mapper<Menu>().map(JSONString: menu)
//            let user = Mapper<Menu>().mapArray(JSONArray: menu)
//            return user
//        }
//        else{
//            return nil
//        }
//    }
    
    func setAppActualizada(value: Bool) -> Void{
        let prefs = UserDefaults.standard
        prefs.set(value, forKey: "AppActualizada")
        prefs.synchronize()
    }
    
    func getAppActualizada() -> Bool
    {
        let prefs = UserDefaults.standard
        let value = prefs.bool(forKey: "AppActualizada")
        return value
    }
}
