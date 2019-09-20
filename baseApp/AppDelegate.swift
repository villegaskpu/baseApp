//
//  AppDelegate.swift
//  baseApp
//
//  Created by David on 8/7/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let themeCustom = VycoTheme()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("ver si es login : \(Settings.sharedInstance.getSesion())")
        LocationUtil.sharedInstance.startUpdatingLocation()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Listo"
        themeCustom.apply(for: application)
        
        var navigationController: UINavigationController!
        
        let vcHome = HomeVC() as UIViewController
        
        
        if Settings.sharedInstance.getSesion() { // si la sesion esta iniciada
//            let vc = principalTabBarVC() as UIViewController
            let vc = TemporalHome() as UIViewController
            navigationController = UINavigationController(rootViewController: vc)
            navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationController.navigationItem.setHidesBackButton(true, animated:true)
            var viewControllers = navigationController.viewControllers
            viewControllers.insert(vcHome, at: 0)
            navigationController.viewControllers = viewControllers
        } else {
            navigationController = UINavigationController(rootViewController: vcHome)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if Settings.sharedInstance.getSesion() { // si la sesion esta iniciada
            print("EnterBackground")
            if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == .authorizedAlways {
                timerHearBeats.invalidate()
                LocationUtil.sharedInstance.stopUpdatingLocation()
                LocationUtil.sharedInstance.startMonitoringSingnificantLocationChanges()
            }
        }
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if Settings.sharedInstance.getSesion() { // si la sesion esta iniciada
            print("EnterBackground")
            if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == .authorizedAlways {
                LocationUtil.sharedInstance.stopMonitoringSignificantLocationChanges()
                LocationUtil.sharedInstance.startUpdatingLocation()
                timerHearBeats = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            
        }
    }
    
    @objc func timerAction() {
        print("solo soy un print")
        Commons.heardBeat()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if Settings.sharedInstance.getSesion() {
//            Commons.wakeup(advertisementId: Commons.identifierForAdvertising())
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        if Settings.sharedInstance.getSesion() {
//            Commons.wakeup(advertisementId: Commons.identifierForAdvertising())
        }
    }
    
    // MARK: createRootViewController
    
    func createRootViewController() -> UIViewController {
        //        let bundle = Bundle(for: ManagerSectionController.self)
        //        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        //
        //        let vc = storyboard.instantiateInitialViewController() as!  ManagerSectionController
        //        return vc
        
//        let bundle = Bundle(for: Login.self)
//        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
//
//        let vc = storyboard.instantiateInitialViewController() as!  Login
        
        let vc = HomeVC()
        return vc
        
    }


}

