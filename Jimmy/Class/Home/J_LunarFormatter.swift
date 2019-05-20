//
//  J_LunarFormatter.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class J_LunarFormatter: NSObject {

    var chineseCalendar : NSCalendar?
    var formatter : DateFormatter?
    var lunarDays : [String] = []
    var lunarMonths : [String] = []
    
    override init() {
        super.init()
        self.chineseCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)
        self.formatter = DateFormatter()
        self.formatter?.calendar = self.chineseCalendar! as Calendar
        self.formatter?.dateFormat = "M"
        self.lunarDays = ["初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","二一","二二","二三","二四","二五","二六","二七","二八","二九","三十"]
        self.lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
        
    }
    
    func stringFrom(date: Date) -> String {
        
        let day = self.chineseCalendar!.component(NSCalendar.Unit.day, from: date)
        if day != 1 {
            return self.lunarDays[day-2]
        }
        
        var monthString = self.formatter!.string(from: date)
        if self.chineseCalendar!.veryShortMonthSymbols.contains(monthString) {
            return self.lunarMonths[monthString.toInt()-1]
        }
        
        let month = self.chineseCalendar!.component(NSCalendar.Unit.month, from: date)
        monthString = "闰\(self.lunarMonths[month-1])"
        
        return monthString
    }
    
    
}
