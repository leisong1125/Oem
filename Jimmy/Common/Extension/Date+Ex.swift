//
//  Date+Ex.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/22.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit


extension Date {
    
    /// 给定格式的时间转字符串
    func toString(format: FormatStyle) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.amSymbol = "上午"
        formatter.pmSymbol = "下午"
        let date = formatter.string(from: self)
        
        return date
    }
    
    func afterMinu(minu: Int) -> Date {
        let currentDate = Date()
        let toDate = Date(timeInterval: TimeInterval(minu*60), since: currentDate)
        return toDate
    }
    
}
