//
//  UIImage+Ex.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/1/31.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit


extension UIImage {
    
    /** 通过颜色生成图片 */
    class func initWith(color:UIColor) -> UIImage {
        
        let rect = CGRect(x:0, y:0, width:100, height:100)
        UIGraphicsBeginImageContext(rect.size)
        //获取上下文
        let context = UIGraphicsGetCurrentContext()
        //填充颜色
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // 兼容oc
    class func initWithGradualColor(start:UIColor,end:UIColor,size:CGSize,type:ImageGradualType) -> UIImage {
        
        return initWithGradualColor(startColor: start, endColor: end, size: size, type: type)
        
    }
    
    
    /** 背景渐变颜色生成图片 */
    class func initWithGradualColor(startColor:UIColor,endColor:UIColor,size:CGSize? = nil,type:ImageGradualType? = nil) -> UIImage {
        
        var image = UIImage()
        
        let newSize = size ?? CGSize(width: 100, height: 100)
        let newType = type ?? .leftToRight
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        context.saveGState()
        
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        
        
        guard let startColorComponents = startColor.cgColor.components else { return image }
        guard let endColorComponents = endColor.cgColor.components else { return image }
        
        let locations:[CGFloat] = [0.0, 1.0]
        
        
        
        let component = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        let gradient = CGGradient.init(colorSpace: colorSpaceRef, colorComponents: component, locations: locations, count: 2)
        
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: newSize.width, y: 0)
        
        
        switch newType {
        case .leftToRight:
            break
            
        case .topToBottom:
            
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: newSize.height)
        case .leftTopCornerToR:
            
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: newSize.width, y: newSize.height)
        case .leftBottomCornerToR:
            
            startPoint = CGPoint(x: 0, y: newSize.height)
            endPoint = CGPoint(x: newSize.width, y: newSize.height)
        }
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [.drawsBeforeStartLocation,.drawsAfterEndLocation])
        
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext()
        context.restoreGState()
        
        return image
    }
}
