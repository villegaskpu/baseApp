//
//  DateExtension.swift
//  baseApp
//
//  Created by David on 9/2/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation


extension Date {
    
    func fistWeekDay() -> Int {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .hour], from: Calendar.current.startOfDay(for: self))
        let date =  Calendar.current.date(from: comp)!
        
        let components = Calendar.current.dateComponents([.weekday], from: date)
        var weekDay = components.weekday!
        
        if weekDay > 1 {
            weekDay = weekDay - 1
        }
        else {
            weekDay = 7
        }
        
        return weekDay
    }
    
    func lastDay() -> Int {
        var comp: DateComponents = Calendar.current.dateComponents([.month, .day, .hour], from: Calendar.current.startOfDay(for: self))
        comp.month = 1
        comp.day = -1
        
        let comp2: DateComponents = Calendar.current.dateComponents([.year, .month, .hour], from: Calendar.current.startOfDay(for: self))
        let firstDay = Calendar.current.date(from: comp2)!
        
        let lastDayDate = Calendar.current.date(byAdding: comp, to: firstDay)
        
        let components = Calendar.current.dateComponents([.day], from: lastDayDate!)
        let lastDay = components.day!
        
        return lastDay
    }
    
    func currentDay(_ twoDigits:Bool = false) -> String {
        let components = Calendar.current.dateComponents([.day], from: self)
        let today = components.day
        
        if today! <= 9
        {
            return "0\(today!)"
        }
        return "\(today!)"
    }
    
    func currentDayOneDigit() -> String {
        let components = Calendar.current.dateComponents([.day], from: self)
        let today = components.day
        
        return "\(today!)"
    }
    
    func currentMonth(_ twoDigits:Bool = false) -> String {
        let components = Calendar.current.dateComponents([.month], from: self)
        let month = components.month
        if month! <= 9 && twoDigits
        {
            return "0\(month!)"
        }
        return "\(month!)"
    }
    
    func currentYear() -> String {
        let components = Calendar.current.dateComponents([.year], from: self)
        let year = components.year
        
        return "\(year!)"
    }
    
    func currentHour(_ twoDigits:Bool = false) -> String {
        let components = Calendar.current.dateComponents([.hour], from: self)
        let hour = components.hour
        if hour! <= 9 && twoDigits
        {
            return "0\(hour!)"
        }
        
        return "\(hour!)"
    }
    
    func currentMinute(_ twoDigits:Bool = false) -> String {
        let components = Calendar.current.dateComponents([.minute], from: self)
        let minute = components.minute
        if minute! <= 9 && twoDigits
        {
            return "0\(minute!)"
        }
        
        return "\(minute!)"
    }
    
    func currentSeconds(_ twoDigits:Bool = false) -> String {
        let components = Calendar.current.dateComponents([.second], from: self)
        let second = components.second
        if second! <= 9 && twoDigits
        {
            return "0\(second!)"
        }
        return "\(second!)"
    }
    
    func getStringDate() -> String {
        
        var returnDate = ""
        
        let components = Calendar.current.dateComponents([.month, .year], from: self)
        let month = components.month
        let year = components.year
        
        returnDate = "\(getMonth(month!)) \(year!)"
        
        return returnDate
    }
    
    func daysBetween(to: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: to)
        
        return components.day! + 1
    }
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
    
    
    func toString(_ withoutHour: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if withoutHour {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        return dateFormatter.string(from: self)
    }
    
    func getTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    mutating func addMonths(value: Int) {
        self = Calendar.current.date(byAdding: .month, value: value, to: self)!
    }
    
    mutating func addHours(value: Int) {
        self = Calendar.current.date(byAdding: .hour, value: value, to: self)!
    }
    
    mutating func addDays(value: Int) {
        self = Calendar.current.date(byAdding: .day, value: value, to: self)!
    }
    
    mutating func updateDate(day: Int = 0, endDay: Bool = false, beginDay: Bool = false) {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        
        if day != 0 {
            components.day = day
        }
        
        if endDay {
            components.hour = 23
            components.minute = 59
            components.second = 59
        }
        else if beginDay {
            components.hour = 0
            components.minute = 0
            components.second = 0
        }
        
        self = Calendar.current.date(from: components)!
    }
    
    /// Returns a Date with the specified days added to the one it is called with
    mutating func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    mutating func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }
    
    private func getMonth(_ mm: Int, corto:Bool = false) -> String {
        var month = ""
        
        switch mm {
        case 1:
            month = (corto) ? "Ene,":"Enero"
            break
        case 2:
            month = (corto) ? "Feb,":"Febrero"
            break
        case 3:
            month = (corto) ? "Mar,":"Marzo"
            break
        case 4:
            month = (corto) ? "Abr,":"Abril"
            break
        case 5:
            month = (corto) ? "May,":"Mayo"
            break
        case 6:
            month = (corto) ? "Jun,":"Junio"
            break
        case 7:
            month = (corto) ? "Jul,":"Julio"
            break
        case 8:
            month = (corto) ? "Ago,":"Agosto"
            break
        case 9:
            month = (corto) ? "Sep,":"Septiembre"
            break
        case 10:
            month = (corto) ? "Oct,":"Octubre"
            break
        case 11:
            month = (corto) ? "Nov,":"Noviembre"
            break
        case 12:
            month = (corto) ? "Dic,":"Diciembre"
            break
        default:
            break
        }
        
        return month
    }
}
