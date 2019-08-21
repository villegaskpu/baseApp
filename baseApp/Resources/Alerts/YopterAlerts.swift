//
//  YopterAlerts.swift
//  Yopter
//
//  Created by David villegas Santana on 21/06/19.
//  Copyright © 2016 David Villegas Santana. All rights reserved.
//

import UIKit
import Foundation
import Lottie

@objc protocol YopterAlertsDelegate {
    @objc optional func YopterAlertsButttonPressed(LeftButton alert: YopterAlerts)
    @objc optional func YopterAlertsButttonPressed(RightButton alert: YopterAlerts)
    @objc optional func YopterAlertsButttonPressed(OneButton alert: YopterAlerts)
    @objc optional func YopterAlertsButtonPressed(LeftButtonTextField alert: YopterAlerts, textFieldText: String)
    @objc optional func YopterAlertsButtonPressed(RightButtonTextField alert: YopterAlerts, textFieldText: String)
}

class YopterAlerts: UIView {

    var delegate: YopterAlertsDelegate?
    var identifier: String = ""
    let CARGANDO = UIView()   //variable global
    private var animator: UIDynamicAnimator!
    private var attachmentBehavior : UIAttachmentBehavior!
    private var alert: UIView!
    private var isTextField = false
    
    //Medidas Alerta
    private var w: CGFloat = 300.0
    private var h: CGFloat = 135.0
    
    //Medidas Botón
    private let btnH: CGFloat = 40.0
    private let btnM: CGFloat = 8.0
    
    //Medidas Titulo
    private let tH: CGFloat = 40.0
    private let tM: CGFloat = 8.0
    
    //Medidas Animación
    private let animHeight: CGFloat = 90.0

    init(title: String, message: String, leftButtonTitle: String, rightButtonTitle: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        configureAlert(message: message)
        setTitleAlert(title: title)
        setBodyAlert(message: message)
        setButtons(firstButtonTitle: leftButtonTitle, secondButtonTitle: rightButtonTitle)
        setAlert()
    }
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        configureAlert(message: message)
        setTitleAlert(title: title)
        setBodyAlert(message: message)
        setButtons(firstButtonTitle: buttonTitle)
        setAlert()
    }
    
    init(title: String, message: String, buttonTitle: String, animationName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        configureAlert(true, message: message)
        setAnimation(animationName)
        setTitleAlert(true, title: title)
        setBodyAlert(true, message: message)
        //setButtons(firstButtonTitle: buttonTitle, color: colorVerde)
        setButtons(firstButtonTitle: buttonTitle, color: UIColor.blue)
        setAlert()
    }
    
    init(title: String, message: String, buttonTitle: String, image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        configureAlert(true, message: message)
        setImage(image)
        setTitleAlert(true, title: title)
        setBodyAlert(true, message: message)
//        setButtons(firstButtonTitle: buttonTitle, color: colorVerde)
        setButtons(firstButtonTitle: buttonTitle, color: UIColor.blue)
        setAlert()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setTextFieldsBorders(textField: UITextField, color: UIColor, width: CGFloat = 0.0, view: UIView? = nil, backgroundColor: UIColor = .white) {
        /*var w = width
         
         if w == 0.0 {
         w = Screen.width
         }
         
         let borderBottom: CALayer = CALayer()
         borderBottom.frame = CGRect(x: 0.0, y: textField.frame.size.height - 1, width: w, height: 1.0)
         borderBottom.backgroundColor = color.cgColor
         textField.layer.addSublayer(borderBottom) */
        
        textField.layer.cornerRadius = 3.0
        textField.layer.borderColor = color.withAlphaComponent(0.4).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = backgroundColor.withAlphaComponent(0.03)
        textField.font = UIFont(name: Font.FONT_REGULAR(), size: 15.0)
        
        if textField.leftView == nil {
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 1.0))
            textField.leftViewMode = .always
        }
    }
    
    init(title: String, textFieldText: String, leftButtonTitle: String, rightButtonTitle: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        isTextField = true
        if Device.iPad {
            w = 400.0
        }
        
        h = 35 + tH + btnH + 2 * tM + 2 * btnM
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = bounds
        
        blurEffectView.contentView.addSubview(vibrancyView)
        addSubview(blurEffectView)
        alpha = 0.0
        
        alert = UIView(frame: CGRect(x: 0.0, y: 0.0, width: w, height: h))
        alert.backgroundColor = .white
        alert.shadow(cornerRadius: 6)
        
        addSubview(alert)
        
        setTitleAlert(title: title)
        
        let textField = UITextField(frame: CGRect(x: tM, y: tH + 2 * tM, width: w - 2 * tM, height: h - tH - 2 * tM - btnH - 2 * btnM))
        textField.text = textFieldText
        textField.delegate = self
        textField.keyboardType = .default
        textField.returnKeyType = .done
        
//        if let target = getTarget() {
//            addToolBar(textField, target: target)
//        }
        
        setTextFieldsBorders(textField: textField, color: .darkGray)
        
        alert.addSubview(textField)
        
        let btnW = (w - 3 * btnM) / 2
        
        let botonIzq = UIButton(frame: CGRect(x: btnM, y: h - btnM - btnH, width: btnW, height: btnH))
        botonIzq.setTitle(leftButtonTitle, for: .normal)
        initButton(boton: botonIzq)
        botonIzq.addTarget(self, action: #selector(self.dismissAlert), for: .touchUpInside)
        botonIzq.addTarget(self, action: #selector(self.buttonleftTextField), for: .touchUpInside)
        
        let botonDer = UIButton(frame: CGRect(x: 2 * btnM + btnW, y: h - btnM - btnH, width: btnW, height: btnH))
        botonDer.setTitle(rightButtonTitle, for: .normal)
        initButton(boton: botonDer)
        botonDer.addTarget(self, action: #selector(self.dismissAlert), for: .touchUpInside)
        botonDer.addTarget(self, action: #selector(self.buttonRightTextField), for: .touchUpInside)
        
        alert.addSubview(botonIzq)
        alert.addSubview(botonDer)
        
        let cw: UIWindow = UIApplication.shared.keyWindow!
        cw.addSubview(self)
        
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func configureAlert(_ withAnimation: Bool = false, message: String) {
        if Device.iPad {
            w = 400.0
        }
        
        let msgSize = (message).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: Font.FONT_REGULAR(), size: 16.0)!])
        var hTemp = (msgSize.width / w) * msgSize.height + tH + btnH + 35 + 2 * tM + 2 * btnM
        
        if withAnimation {
            hTemp = (msgSize.width / w) * msgSize.height + tH + btnH + 35 + 2 * tM + 2 * btnM + animHeight
        }
        
        h = hTemp < h ? h : hTemp
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = bounds
        
        blurEffectView.contentView.addSubview(vibrancyView)
        addSubview(blurEffectView)
        alpha = 0.0
        
        alert = UIView(frame: CGRect(x: 0.0, y: 0.0, width: w, height: h))
        alert.backgroundColor = .white
        alert.shadow(cornerRadius: 6)
        addSubview(alert)
    }
    
    private func setAnimation(_ animationName: String) {
        
        let viewContainer = UIView(frame: CGRect(x: 0.0, y: 0.0, width: alert.bounds.width, height: animHeight))
        viewContainer.backgroundColor = .clear
        
        let viewTop = UIView(frame: CGRect(x: 0.0, y: 0.0, width: alert.bounds.width, height: animHeight / 2.0))
        //viewTop.backgroundColor = colorAzul
        viewTop.backgroundColor = UIColor.blue
        
        let circleSize = animHeight - 10.0
        let circleContainer = UIView(frame: CGRect(x: viewContainer.bounds.midX - circleSize / 2.0, y: 5.0, width: circleSize, height: circleSize))
//        circleContainer.backgroundColor = colorAzul
        circleContainer.backgroundColor = UIColor.blue
        circleContainer.layer.cornerRadius = circleSize / 2
        
        let viewAnim = AnimationView(name: animationName)
        viewAnim.frame = CGRect(x: 2.0, y: 2.0, width: circleSize - 4.0, height: circleSize - 4.0)
        viewAnim.backgroundColor = .white
        viewAnim.layer.cornerRadius = (circleSize - 4.0) / 2
        viewAnim.contentMode = .scaleAspectFit
        viewAnim.loopMode = .loop
        viewAnim.play()
        
        circleContainer.addSubview(viewAnim)
        
        viewContainer.addSubview(viewTop)
        viewContainer.addSubview(circleContainer)
        
        alert.addSubview(viewContainer)
    }
    
    private func setImage(_ image: UIImage) {
        
        let viewContainer = UIView(frame: CGRect(x: 0.0, y: 0.0, width: alert.bounds.width, height: animHeight))
        viewContainer.backgroundColor = .clear
        
        let viewTop = UIView(frame: CGRect(x: 0.0, y: 0.0, width: alert.bounds.width, height: animHeight / 2.0))
//        viewTop.backgroundColor = colorAzul
        viewTop.backgroundColor = UIColor.blue
        
        let circleSize = animHeight - 10.0
        let circleContainer = UIView(frame: CGRect(x: viewContainer.bounds.midX - circleSize / 2.0, y: 5.0, width: circleSize, height: circleSize))
//        circleContainer.backgroundColor = colorAzul
        circleContainer.backgroundColor = UIColor.blue
        circleContainer.layer.cornerRadius = circleSize / 2
        circleContainer.clipsToBounds = true
        
        let image = UIImageView(image: image)
        image.frame = CGRect(x: 2.0, y: 2.0, width: circleSize - 4.0, height: circleSize - 4.0)
        image.backgroundColor = .white
        image.layer.cornerRadius = (circleSize - 4.0) / 2
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        circleContainer.addSubview(image)
        
        viewContainer.addSubview(viewTop)
        viewContainer.addSubview(circleContainer)
        
        alert.addSubview(viewContainer)
    }
    
    
    private func setTitleAlert(_ withAnimation: Bool = false, title: String) {
        var frame: CGRect!
        
        if withAnimation {
            frame = CGRect(x: tM, y: tM + animHeight, width: w - 2 * tM, height: tH)
        }
        else {
            frame = CGRect(x: tM, y: tM, width: w - 2 * tM, height: tH)
        }
        
        let titulo = UILabel(frame: frame)
        titulo.text = title
        titulo.textAlignment = .center
        titulo.font = UIFont(name: Font.FONT_MEDIUM(), size: 22.0)
        titulo.adjustsFontSizeToFitWidth = true
        titulo.minimumScaleFactor = 0.3
        titulo.textColor = .black
        alert.addSubview(titulo)
    }
    
    private func setBodyAlert(_ withAnimation: Bool = false, message: String) {
        var frame: CGRect!
        
        if withAnimation {
            frame = CGRect(x: tM, y: tH + 2 * tM + animHeight, width: w - 2 * tM, height: h - tH - 2 * tM - btnH - 2 * btnM - animHeight)
        }
        else {
            frame = CGRect(x: tM, y: tH + 2 * tM, width: w - 2 * tM, height: h - tH - 2 * tM - btnH - 2 * btnM)
        }
        
        let mensaje = UILabel(frame: frame)
        mensaje.text = message
        mensaje.numberOfLines = 10
        mensaje.textAlignment = .center
        mensaje.textColor = .darkGray
        mensaje.font = UIFont(name: Font.FONT_REGULAR(), size: 16.0)
        alert.addSubview(mensaje)
    }
    
//    private func setButtons(firstButtonTitle: String, secondButtonTitle: String = "", color: UIColor = .SOAzul) {
    private func setButtons(firstButtonTitle: String, secondButtonTitle: String = "", color: UIColor = UIColor.blue) {
    
        if secondButtonTitle.isEmpty {
            let btnW = w - 2 * btnM
            
            let boton = UIButton(frame: CGRect(x: btnM, y: h - btnM - btnH, width: btnW, height: btnH))
            boton.setTitle(firstButtonTitle, for: .normal)
            initButton(boton: boton, backgroundColor: color)
            boton.addTarget(self, action: #selector(self.dismissAlert), for: .touchUpInside)
            boton.addTarget(self, action: #selector(self.buttonOne), for: .touchUpInside)
            
            alert.addSubview(boton)
        }
        else {
        
            let btnW = (w - 3 * btnM) / 2
            
            let botonIzq = UIButton(frame: CGRect(x: btnM, y: h - btnM - btnH, width: btnW, height: btnH))
            botonIzq.setTitle(firstButtonTitle, for: .normal)
            initButton(boton: botonIzq, backgroundColor: color)
            botonIzq.addTarget(self, action: #selector(self.dismissAlert), for: .touchUpInside)
            botonIzq.addTarget(self, action: #selector(self.buttonleft), for: .touchUpInside)
            
            let botonDer = UIButton(frame: CGRect(x: 2 * btnM + btnW, y: h - btnM - btnH, width: btnW, height: btnH))
            botonDer.setTitle(secondButtonTitle, for: .normal)
            initButton(boton: botonDer, backgroundColor: color)
            botonDer.addTarget(self, action: #selector(self.dismissAlert), for: .touchUpInside)
            botonDer.addTarget(self, action: #selector(self.buttonRight), for: .touchUpInside)
            
            alert.addSubview(botonIzq)
            alert.addSubview(botonDer)
        }
    }
    
    private func setAlert() {
        let cw: UIWindow = UIApplication.shared.keyWindow!
        cw.addSubview(self)
        
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func createGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        alert.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        
        
        let locationInSelf = sender.location(in: self)
        let locationInAlert = sender.location(in: alert)

        switch sender.state {
            case .began:
                animator.removeAllBehaviors()
                
                let offset = UIOffset(horizontal: locationInAlert.x - alert.bounds.midX, vertical: locationInAlert.y - alert.bounds.midY)
                attachmentBehavior = UIAttachmentBehavior(item: alert, offsetFromCenter: offset, attachedToAnchor: locationInSelf)
                animator.addBehavior(attachmentBehavior)
                
                break
            case .changed:
                attachmentBehavior.anchorPoint = locationInSelf
                
                break
            case .ended:
                animator.removeAllBehaviors()
                let snapBehavior = UISnapBehavior(item: alert, snapTo: center)
                animator.addBehavior(snapBehavior)
                
                if sender.translation(in: self).y > 100 || sender.translation(in: self).y < -100.0 {
                    dismissAlert()
                }
            
                break
            
            default:
                break
        }
    }
    
    func presentAlert(_ removeLoad: Bool = true) {
        
        if removeLoad {
            removeLoading()
        }
        createGestureRecognizer()
        animator.removeAllBehaviors()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        }) { _ in
            
            for textField in self.alert.subviews where textField is UITextField {
                textField.becomeFirstResponder()
            }
        }
        
        var center = self.center
        
        if isTextField && Device.iPhone5 {
            center = CGPoint(x: self.center.x, y: self.bounds.height * 0.3)
        }
        
        let snapBehaviour = UISnapBehavior(item: alert, snapTo: center)
        snapBehaviour.damping = 0.3
        animator.addBehavior(snapBehaviour)
    }
    
    @objc func dismissAlert() {
        
        animator.removeAllBehaviors()
        
        let gravityBehaviour = UIGravityBehavior(items: [alert])
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 10.0)
        animator.addBehavior(gravityBehaviour)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [alert])
        itemBehaviour.addAngularVelocity(-CGFloat.pi / 2, for: alert)
        animator.addBehavior(itemBehaviour)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }, completion: { void in
            self.removeFromSuperview()
        })
    }
    
    @objc private func buttonleft() {
        delegate?.YopterAlertsButttonPressed?(LeftButton: self)
    }
    
    @objc private func buttonRight() {
        delegate?.YopterAlertsButttonPressed?(RightButton: self)
    }
    
    @objc private func buttonleftTextField() {
        for view in alert.subviews where view is UITextField {
            let textFieldText = (view as! UITextField).text
            delegate?.YopterAlertsButtonPressed?(LeftButtonTextField: self, textFieldText: textFieldText!)
            break
        }
    }
    
    @objc private func buttonRightTextField() {
        
        for view in alert.subviews where view is UITextField {
            let textFieldText = (view as! UITextField).text
            delegate?.YopterAlertsButtonPressed?(RightButtonTextField: self, textFieldText: textFieldText!)
            break
        }
    }
    
    @objc private func buttonOne() {
        delegate?.YopterAlertsButttonPressed?(OneButton: self)
    }
    
    
    
//    public func initButton(boton: UIButton, backgroundColor: UIColor = colorAzul, textColor: UIColor = UIColor.white) {
    public func initButton(boton: UIButton, backgroundColor: UIColor = UIColor.blue, textColor: UIColor = UIColor.white) {
        boton.setTitleColor(textColor, for: UIControl.State())
        boton.setTitleColor(UIColor.darkGray, for: .selected)
        boton.setTitleColor(UIColor.darkGray, for: .highlighted)
        boton.backgroundColor = backgroundColor
        boton.titleLabel?.font = UIFont(name: Font.FONT_REGULAR(), size: 17)
        boton.layer.masksToBounds = false
        boton.layer.shadowColor = UIColor.black.cgColor
        boton.layer.shadowOpacity = 0.5
        
        if let text = boton.titleLabel?.text?.capitalized {
            boton.setTitle(text, for: .normal)
        }
        
        boton.layer.shadowRadius = 1.5
        boton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        boton.layer.cornerRadius = 6.0
        boton.layer.borderWidth = 0.0
        boton.layer.borderColor = UIColor.white.cgColor
        boton.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    func removeLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.CARGANDO.alpha = 0.0
        },completion: { void in
            self.CARGANDO.removeFromSuperview()
        })
    }
}
extension YopterAlerts: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
