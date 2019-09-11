//
//  BViewController.swift
//  CoreIOS
//
//  Created by David on 6/28/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit
import MessageUI
import NVActivityIndicatorView
import Lottie

public class BViewController: UIViewController {

//    public var sessionManager = SessionManager()
    private let loadingContainer = UIView()
    private var messageView = UIView()
    
    let refreshControl = UIRefreshControl()
    
    
    let CARGANDO = UIView()   //variable global
    let reachability = Reachability.forInternetConnection()!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        
    }
    
    func showLoading(overCurrentContext: Bool = false) {
        
        for subview in loadingContainer.subviews {
            subview.removeFromSuperview()
        }
        
        loadingContainer.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        loadingContainer.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        loadingContainer.alpha = 0.0
        
        let frameAct = CGRect(x: Screen.width/2 - 20.0, y: Screen.height/2, width: 40.0, height: 40.0)
        
        let actv = NVActivityIndicatorView(frame: frameAct, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.hexStringToUIColor(hex: "#20476E"), padding: 0.0)
        actv.startAnimating()
        
        loadingContainer.addSubview(actv)
        
        if overCurrentContext {
            if let w = UIApplication.shared.keyWindow {
                w.addSubview(loadingContainer)
            }
        }
        else {
            view.addSubview(loadingContainer)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingContainer.alpha = 1.0
        })
    }
    
    
    func hideLoading() {
        UIView.animate(withDuration: 0.8, animations: {
            self.loadingContainer.alpha = 0.0
        },completion: { void in
            self.loadingContainer.removeFromSuperview()
        })
    }
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients([Constants.emailContact])
            mail.setSubject(Constants.emailSubject)
            mail.setMessageBody("<br /><br /><br /><br /><br /><br /><br /><br /><br />\(Commons.getUserAgentForEmail())", isHTML: true)

            present(mail, animated: true)
        } else {
            Commons.showMessage("SEND_EMAIL_UNAVAILABLE".localized)
        }
    }
    
    func sendEmailWithRecipient(_ recipient: String) {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
//            mail.setToRecipients([recipient])
//            mail.setSubject(Constants.emailSubject)
//            mail.setMessageBody("<br /><br /><br /><br /><br /><br /><br /><br /><br />\(Commons.getUserAgent())", isHTML: true)
//            
//            present(mail, animated: true)
//        } else {
//            Commons.showMessage("SEND_EMAIL_UNAVAILABLE".localized)
//        }
    }
    
    @objc(mailComposeController:didFinishWithResult:error:) func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func cargandoItem(_ target: AnyObject, message: String = "", activity: Bool, name: String = "gps") {
        
        for subview in CARGANDO.subviews {
            subview.removeFromSuperview()
        }
        
        CARGANDO.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        CARGANDO.backgroundColor = UIColor.white
        CARGANDO.alpha = 0.0
        
        let cw: UIWindow = UIApplication.shared.keyWindow!
        cw.addSubview(CARGANDO)
        
        let loading = AnimationView(name: name)
        loading.frame = CGRect(x: Screen.midX - 100, y: Screen.midY - 100, width: 200, height: 200)
        loading.contentMode = .scaleAspectFit
        loading.loopMode = .loop
        loading.play()
        
        CARGANDO.addSubview(loading)
        
        if !message.isEmpty {
            let LabelText = UILabel()
            LabelText.frame = CGRect(x: Screen.midX - 100, y: Screen.midY + 150, width: 200, height: 100)
            LabelText.numberOfLines = 0
            LabelText.text = message
            LabelText.backgroundColor = UIColor.clear
            LabelText.textAlignment = .center
            LabelText.font = UIFont(name: Font.FONT_BOLD(), size: 20.0)
            LabelText.textColor = UIColor.black
            CARGANDO.addSubview(LabelText)
        }
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.CARGANDO.alpha = 1.0
        })
    }
    
    func removeLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.CARGANDO.alpha = 0.0
        },completion: { void in
            self.CARGANDO.removeFromSuperview()
        })
    }
    
    
    func setTitleview(logoImage: UIImage? = nil) -> UIView {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        titleView.backgroundColor = .clear
        
        var image = #imageLiteral(resourceName: "homeLogo")
        
        if let img = logoImage {
            image = img
        }
        
        let logo = UIImageView(image: image)
        logo.contentMode = .scaleAspectFit
        logo.frame = titleView.bounds
        
        titleView.addSubview(logo)
        
        return titleView
    }
}
