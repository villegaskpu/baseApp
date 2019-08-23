//
//  StatusCode.swift
//  baseApp
//
//  Created by David on 8/20/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import a4SysCoreIOS


class StatusCode {
    
    
    static func strStatusCode(endPoint: endPoint, StatusCode: String) -> String {
        
        switch endPoint {
        case .Login:
            return strLoguin(statusCore: StatusCode)
        default:
            return ""
        }
    }
    
    
    private static func strLoguin(statusCore: String) -> String {
        
        switch statusCore {
        case "401":
            return "Usuario y/o contraseña incorrectos"
        case "1000":
            return "Oferta ya tomada"
        case "1001":
            return "El correo electrónico ingresado ya fue registrado anteriormente"
        case "1002":
            return "El código ingresado no existe"
        case "1003":
            return "El código ingresado ya ha sido registrado anteriormente"
        case "1004":
            return "Cantidad superada de registros por dispositivo"
        case "1006":
            return "Correo electrónico ingresado no existe"
        default:
            return "Ocurrio algo inesperado"
        }
    }
    
    static func validateStatusCode(code: Int) -> Bool{
        
        return code >= 200 && code < 300
    }
}
