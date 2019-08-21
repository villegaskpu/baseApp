//
//  StringExtension.swift
//  Yopter
//
//  Created by Yoptersys on 3/30/17.
//  Copyright © 2017 Yopter. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let finalMutableAttributedString = try NSMutableAttributedString.init(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
           if self.count > 0
           {
            finalMutableAttributedString.addAttribute(.foregroundColor, value: UIColor(red: 31/255, green: 53/255, blue: 94/255, alpha: 1.0), range: NSRange.init(location: 0, length: finalMutableAttributedString.string.count - 1))
            }
            
            return finalMutableAttributedString
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var localized: String{
       return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
    
    func capitalizingFirstLetter() -> String
    {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    func convertWeekdaysIntoSchedule() -> String
    {
        var formatString = String.init()
        var index = 0
        for character in self
        {
            switch(character)
            {
            case "L": formatString.append("L")
                break
            case "M": formatString.append("Ma")
                break
            case "I": formatString.append("Mi")
                break
            case "J": formatString.append("J")
                break
            case "V": formatString.append("V")
                break
            case "S":   formatString.append("S")
                break
            case "D": formatString.append("D")
                break
            default:
                break
            }
            
            formatString.append(index == self.count - 1 ? "" : ",")
            index += 1
        }
        
        return formatString
    }
}
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
extension String
{
    func toFloat() -> Float? {
        return Float.init(self)
    }
    
    func toDouble() -> Double? {
        return Double.init(self)
    }
    
    func toInt() -> Int? {
        return Int.init(self)
    }
}

