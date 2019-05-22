//
//  String+Ex.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/1/29.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit
import SwiftDate

extension String{
    
    //截取字符 To
    func subToOffset(right:Int) ->String {
        
        if self.count < right {
            
            return self
        }
        let index = self.index(self.startIndex, offsetBy: right)
        return String(self.prefix(upTo: index))
    }
    //截取字符 From
    func subFromOffset(left:Int) ->String {
        
        if self.count < left {
            
            return ""
        }
        let index = self.index(self.startIndex, offsetBy: left)
        return String(self.suffix(from: index))
    }
    
    //md5
    func md5() -> String {
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash.lowercased //String(format: hash as String)
    }
    
    /// 截取字符串 n到m
    subscript (start: Int, end: Int) -> String? {
        if start > self.count || start < 0 || start > end {
            return nil
        }
        let begin = self.index(self.startIndex, offsetBy: start)
        var terminal: Index
        if end >= count {
            terminal = self.index(self.startIndex, offsetBy: count)
        } else {
            terminal = self.index(self.startIndex, offsetBy: end + 1)
        }
        let range = (begin ..< terminal)
        return String(self[range])//self.substring(with: range)
    }
    //获取第n个字符
    subscript (index: Int) -> String? {
        
        if index > self.count - 1 || index < 0 {
            return nil
        }
        
        let c = self[self.index(self.startIndex, offsetBy: index)]
        return String(c)
    }
}

extension String {
    
    //得到字符串
    static func getFrom(dict:Dictionary<String,AnyObject>) ->String? {
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: 0))
        
        let jsonStr = String.init(data: data ?? Data(), encoding: String.Encoding.utf8)
        return jsonStr
        
    }
    // to Double
    func toDouble() -> Double {
        
        return Double(self) ?? 0.0
    }
    
    // to CGFloat
    func toCGFloat() -> CGFloat {
        
        return CGFloat(self.toDouble())
    }
    
    // to Double
    func toInt() -> Int {
        
        return Int(self.toDouble())
    }
    
    func toBool() -> Bool {
        
        if self.lowercased() == "true" {
            return true
        }
        return false
    }
    
    func toDate(format: FormatStyle) -> Date {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format.rawValue
        
        let date = dateFormatter.date(from: self)
        
        return date!
    }
    
    /**
     只保留 字符串中的 数字
     
     @param iOS 11读取通讯录手机号“空格”bug
     @return bool
     */
    func phoneNumberFormat() -> String {
        
        let regular = try? NSRegularExpression(pattern: "[^\\d]", options: NSRegularExpression.Options(rawValue: 0))
        
        let numberStr = regular?.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: "")
        
        return numberStr ?? ""
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        
        let utf16view = self.utf16
        
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
            
        }
        
        return nil
        
    }
}

