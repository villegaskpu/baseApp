//
//  Constants.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright � 2017 Yopter. All rights reserved.
//

import UIKit

let constantsParameters:[String:Any] = ["baseURLString" : "https://fyf5tabava.execute-api.us-east-1.amazonaws.com/pro",
                                         "newBaseURLString" : "https://tms93ofcxe.execute-api.us-east-1.amazonaws.com/pro",
                                         "appID" : "1ed3d6e03ee03c04bf3365f808fc28f1",
                                         "token" : "\(Settings.sharedInstance.getAccessToken() ?? "")",
                                         "tokenYopter" : "\(Settings.sharedInstance.getOldToken() ?? "")"
]

struct Constants{
    static let baseURLString = "https://fyf5tabava.execute-api.us-east-1.amazonaws.com/pro"
    static let newBaseURLString = "https://tms93ofcxe.execute-api.us-east-1.amazonaws.com/pro"
    static let appID = "1ed3d6e03ee03c04bf3365f808fc28f1"
    static let appIDTienda = "1464721739"
    static let appName = "Vyco Comunica perro"
    static let contentType = "application/json"
    static let accept = "application/json"
    static let uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    static let beaconRegionName = "Yopter"
    static let temperature = "38"
    static let idCountry = 141
    static let hasCode = true
    static let isCodeOptional = true
    static let nameToSignUp = "Yopter"
    static let lastNameToSignUp = "Yopter"
    static let cellToSignUp = "0000000000"
    static let language = "es-MX"
    static let emailContact = "contacto@yopter.com"
    static let emailSubject = "contacto@yopter.com"
    static let numberOfRowsPerPage = 25
    static let movementTextFieldDistance : CGFloat = 80.0
    static let animationDurationTextField = 0.3
    static let defaultColor = UIColor.init(red: 180/255, green: 3/255, blue: 56/255, alpha: 1)
    static let secondColor = UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
    static let thirdColor = UIColor.black
}
