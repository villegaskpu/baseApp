//
//  Commons.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import Foundation
import CoreTelephony
import UIKit
import AdSupport

class Commons{
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}(\\.[A-Za-z]+)?"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func getUserAgent() -> String
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        
        let carrierName = carrier?.carrierName ?? "Ipad"
        
        return String(format:"%@/%@ (v%@) (iOS %@; %@; %@)(%@)", Bundle.main.bundleIdentifier!, Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String, Bundle.main.infoDictionary!["CFBundleVersion"] as! String, UIDevice.current.systemVersion, Locale.current.identifier, identifier, carrierName)
    }
    
    static func getCurrentDateForSupport() -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ss"
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        return dateFormatter.string(from: Date.init()).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func getUserAgentForEmail() -> String
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        
        let carrierName = carrier?.carrierName ?? "Ipad"
        
        return String(format:"%@/%@ (v%@) (iOS %@; %@; %@)(%@)", "Comunica", Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String, Bundle.main.infoDictionary!["CFBundleVersion"] as! String, UIDevice.current.systemVersion, Locale.current.identifier, identifier, carrierName)
    }
    
    static func getCurrentDate(_ addYears: Int = 0) -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        
        if addYears != 0 {
            return ""//dateFormatter.string(from: Date.init().addYears(n: addYears)).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return dateFormatter.string(from: Date.init()).trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    static func getShortCurrentDate() -> String
    {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        return dateFormatter.string(from: Date.init()).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func getShortDateSinceSevenDay() -> String
    {
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        
        date = cal.date(byAdding: .day, value: -7, to: date)!
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        return dateFormatter.string(from: date).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func showMessage(_ content : String, duration: TTGSnackbarDuration = .middle)
    {
        let snackbar = TTGSnackbar.init(message: content, duration: duration)
        snackbar.show()
    }
    
    static func generateCode128(code: String) -> UIImage
    {
        let data = code.data(using: .ascii)
        let filter = CIFilter.init(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue(NSNumber.init(value: 7.0) , forKey: "inputQuietSpace")
        
        let code128Image = filter?.outputImage
        let imageSize = code128Image?.extent
        let outputSize = CGSize.init(width: 270, height: 160)
        
        let code128Resize = code128Image?.transformed(by: CGAffineTransform.init(scaleX: outputSize.width/(imageSize?.width)!, y: outputSize.height/(imageSize?.height)!))
        let code128ByTransform = UIImage.init(ciImage: code128Resize!)
        
        return code128ByTransform
    }
    
    static func generateCodeQR(code: String) -> UIImage
    {
        let data = code.data(using: .ascii)
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        let codeQRImage = filter?.outputImage
        let imageSize = codeQRImage?.extent
        let outputSize = CGSize.init(width: 200, height: 200)
        
        let codeQRResize = codeQRImage?.transformed(by: CGAffineTransform.init(scaleX: outputSize.width/(imageSize?.width)!, y: outputSize.height/(imageSize?.height)!))
        let codeQRByTransform = UIImage.init(ciImage: codeQRResize!)
        
        return codeQRByTransform
        
    }
    
    static func compareVersion(local: String, _ tienda: String) -> Bool {
        
        var v1 = local.split(separator: "-").map{ String($0) }
        var v2 = tienda.split(separator: "-").map { String($0) }
        
//        if let local = Int(v1[0].replace(target: ".", withString:"")), let tienda = Int(v2[0].replace(target: ".", withString:"")) {
//            if local < tienda {
//                return false
//            } else {
//                if local == tienda {
//                    if let localB = Int(v1[1]), let tiendaB = Int(v2[1]) {
//                        if localB < tiendaB {
//                            return false
//                        } else {
//                            return true
//                        }
//                    }
//                }
//            }
//        }
        
        return true
    }
    
    static func checkIfWifi() -> (Bool, String)
    {
//        let reachability = Reachability.forInternetConnection()
//
//        let networkStatus = reachability?.currentReachabilityStatus()
//
//        switch(networkStatus!)
//        {
//        case NotReachable:
//            return (false, "N")
//        case ReachableViaWiFi:
//            return (true, "W")
//        case ReachableViaWWAN:
//            return (true, "D")
//        default:
//            return (false, "N")
//        }
        
        return (true, "")
    }
    
    static func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        
        let digits = Constants.baseURLString
        let index4 = digits.index(digits.startIndex, offsetBy: digits.count-3)
        let str = digits.suffix(from: index4) == "est" ? "test" : digits.suffix(from: index4)
        return "V\(version)(\(build))/\(str)"
    }
    
    static func createDirectory(){
        
        let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath1.appendingPathComponent("imgCamaleon")
        do
        {
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
    }
    
    static func deleteDirectory() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("imgCamaleon")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("imgCamaleon")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    
    
    static func getDirectoryPath() -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("imgCamaleon")
        let url = NSURL(string: path)
        return url!
    }
    
    
    static func saveImageDocumentDirectory(image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("imgCamaleon")
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        //let imageData = image.jpegData(compressionQuality: 0.5)
        //UIImageJPEGRepresentation(image, 0.5)
        let imageData = image.pngData()
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
    
    static func getImageFromDocumentDirectory() -> UIImage {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent("logoHome.jpg")
        let urlString: String = imagePath!.absoluteString
        if fileManager.fileExists(atPath: urlString) {
            let image = UIImage(contentsOfFile: urlString)
            //imageArray.append(image!)
            return image!
        } else {
            print("No Image")
            
            return UIImage(named: "televisa_nav")!
        }
    }
    
    static func setImageLogo() -> UIImage {
        let image = getImageFromDocumentDirectory()
        return image
    }
    
    static func windowMessage(message: String, buttonTitle: String = "", action: Selector? = nil,action2: Selector? = nil, target: Any? = nil) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        //view.backgroundColor = UIColor.groupTableViewBackground
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bgDark")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFit
        view.insertSubview(backgroundImage, at: 0)
        
        view.alpha = 0.0
        
        let imageName = "homeLogo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: Screen.width/2 - 125, y: 40, width: 250, height: 120)
        view.addSubview(imageView)
        
        
        let label = UILabel(frame: CGRect(x: Screen.midX - 150, y: Screen.midY - 75, width: 300, height: 150))
        label.text = message
        label.font = UIFont(name: "Avenir-Medium", size: 25.0)
        label.numberOfLines = 10
        label.textAlignment = .center
        label.textColor = .white
        
        view.addSubview(label)
        view.tag = 999999
        
        if !buttonTitle.isEmpty {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: Screen.midX - 150, y: Screen.midY + 75, width: 300, height: 50)
            button.backgroundColor = UIColor.hexStringToUIColor(hex: "#5ACAD0")
            button.layer.cornerRadius = 10.0
            button.titleLabel?.textColor = UIColor.white
            
            button.setAttributedTitle(NSAttributedString(string: buttonTitle, attributes: [.font: UIFont(name: "Avenir-Medium", size: 20.0)!]), for: .normal)
            
            if let selector = action, let target = target{
                button.addTarget(target, action: selector, for: .touchUpInside)
            }
            
            view.addSubview(button)
        }
        
        
        if let selector = action2, let target = target{
            
            let button2 = UIButton(type: .custom)
            button2.frame = CGRect(x: Screen.midX - 150, y: Screen.midY + 165, width: 300, height: 50)
            button2.backgroundColor = UIColor.hexStringToUIColor(hex: "#D36F27")
            button2.layer.cornerRadius = 10.0
            button2.titleLabel?.textColor = UIColor.white
            
            button2.setAttributedTitle(NSAttributedString(string: "Descargar mas tarde", attributes: [.font: UIFont(name: "Avenir-Medium", size: 20.0)!]), for: .normal)
            
            button2.addTarget(target, action: selector, for: .touchUpInside)
            
            // quitar vista de descargar el app
            if checkIfWifi().1 != "W" {
                view.addSubview(button2)
            }
        }
        
        if let w = UIApplication.shared.keyWindow {
            if let _ = w.viewWithTag(999999) {
                print("existe")
            } else {
                print("no existe")
                w.addSubview(view)
            }
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 1.0
        })
    }
    
    static func removeWindowMessage() {
        print("hola")
        if let w = UIApplication.shared.keyWindow {
            if let viewWithTag = w.viewWithTag(999999) {
                viewWithTag.removeFromSuperview()
            }
            else{
                print("No existe windowMessage!")
            }
        }
    }
    
    static func windowInternetError(action: Selector? = nil, target: Any? = nil) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        view.tag = 9999988
        view.alpha = 0.0
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "errorInternet")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImage.frame = CGRect(x: 10, y: 20, width: Screen.width - 20.0, height: Screen.height - 40.0)
        view.insertSubview(backgroundImage, at: 0)
        
        if action != nil {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: Screen.midX - 100, y: Screen.midY + 180, width: 200, height: 50)
            button.backgroundColor = UIColor.hexStringToUIColor(hex: "#f2f2f2")
            button.layer.cornerRadius = 10.0
            button.titleLabel?.textColor = UIColor.hexStringToUIColor(hex: "#bcbcbc")
            
            
            button.setAttributedTitle(NSAttributedString(string: "Reintentar", attributes: [.font: UIFont(name: "Avenir-Medium", size: 20.0)!]), for: .normal)
            
            if let selector = action, let target = target {
                button.addTarget(target, action: selector, for: .touchUpInside)
            }
            
            view.addSubview(button)
        }
        
        if let w = UIApplication.shared.keyWindow {
            if let _ = w.viewWithTag(9999988) {
                print("existe")
            } else {
                print("no existe")
                w.addSubview(view)
            }
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 1.0
        })
    }
    
    static func removeWindowInternetError() {
        if let w = UIApplication.shared.keyWindow {
            if let viewWithTag = w.viewWithTag(9999988) {
                viewWithTag.removeFromSuperview()
            }
            else{
                print("No existe windowInternetError!")
            }
        }
    }
    
    static func heardBeat() {
//        let sessionManager = SessionManager()
//        let parameters = [[
//            "latitude": "\(LocationUtil.sharedInstance.currentLocation?.coordinate.latitude ?? 0)",
//            "longitude": "\(LocationUtil.sharedInstance.currentLocation?.coordinate.longitude ?? 0)",
//            "beatAt": Commons.getCurrentDate()]]
//
//
//        if Commons.checkIfWifi().0 { // checar si tiuene internet
//            sessionManager.request(YopterRouter.HeartBeat(parameter: parameters)).responseJSON{ (response) in
//                switch(response.result)
//                {
//                case .success(_):
//                    if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300
//                    {
//                        print("heartbeat ok")
//                    }
//                    else
//                    {
//                        print("getBeat() Error heartbeat")
//                        print("FAIL_CONNECTION_SERVICE".localized)
//                    }
//                case .failure(_):
//                    print("FAIL_CONNECTION_SERVICE".localized)
//                }
//            }
//        }
    }
    static func wakeup(advertisementId:String?)
    {
//        if ((Settings.sharedInstance.getToken() != nil &&
//            Settings.sharedInstance.getToken() != "" &&
//            Settings.sharedInstance.getUsername() != nil &&
//            Settings.sharedInstance.getUsername() != "") &&
//            Settings.sharedInstance.getAnonymous() != "") || (Settings.sharedInstance.getAccessToken() != nil && Settings.sharedInstance.getAccessToken() != "")
//        {
//            let sessionManager = SessionManager()
//            sessionManager.request(YopterRouter.WakeUp(parameter: Requests.createWakeUpRequest(advertisementId: advertisementId))).validate(statusCode: 200..<300).responseObject{ (response: DataResponse<WakeUpResponse>) in
//                switch(response.result)
//                {
//                case .success(let value):
//                    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//                    let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
//                    let storeVersion = value.iOSVersion ?? ""
//
//                    let ver = currentVersion + "-" + build
//                    let resultCompare = Commons.compareVersion(local: ver, storeVersion)
//                    Settings.sharedInstance.setAppActualizada(value: resultCompare)
////                    NotificationCenter.default.post(.init(name: .AppActualizadaMessaging))
//
//                case .failure(_):
//                    break
//                }
//            }
//        }
    }
    
    static func identifierForAdvertising() -> String? {
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else{
            return nil
        }
        
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    static func isValidEmail(test: String) -> Bool{
        //let emailRegex = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegex =  "^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$" // validacion del backend
        let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: test)
    }
    
}
struct Screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(Screen.width, Screen.height)
    static let minLength = min(Screen.width, Screen.height)
    static let midX = UIScreen.main.bounds.midX
    static let midY = UIScreen.main.bounds.midY
    static let bounds = UIScreen.main.bounds
}

struct Device {
    static let iPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && Screen.maxLength < 568.0
    static let iPhone5 = UIDevice.current.userInterfaceIdiom == .phone && Screen.maxLength == 568.0
    static let iPhone6 = UIDevice.current.userInterfaceIdiom == .phone && Screen.maxLength == 667.0
    static let iPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && Screen.maxLength == 736.0
    static let iPhoneX = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && Screen.maxLength == 812.0
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad && Screen.maxLength == 1024.0
}


