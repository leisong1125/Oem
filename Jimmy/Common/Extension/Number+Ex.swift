//
//  Number+Ex.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/1/29.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit

extension NSNumber {
    
    func toString() -> String {
        return String.init(format: "%d", self)
    }
    
}

extension Double {
    /// 保留两位小数
    func toString() -> String {
        return String.init(format: "%.2f", self)
    }
}

extension Float {
    
    /// 保留两位小数
    func toString() -> String {
        return String.init(format: "%.2f", self)
    }
}

extension UInt{
    func toInt() -> Int {
        return Int(self)
    }
}

extension Int {
    func toString() -> String {
        return String.init(format: "%d", self)
    }
}
