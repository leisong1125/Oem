//
//  UIWindow+Ex.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/1/30.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UIWindow {
    
    var topMostWindowController : UIViewController?{
        get{
            var topVC = self.rootViewController
            while topVC?.presentedViewController != nil {
                topVC = topVC?.presentedViewController
            }
            return topVC
        }
    }    
    
    var currentVC : UIViewController?{
        
        get{
            var currentViewController = topMostWindowController
            
            while (currentViewController is UINavigationController) && (currentViewController as? UINavigationController)?.topViewController != nil {
                currentViewController = (currentViewController as? UINavigationController)?.topViewController
            }
            return currentViewController
        }
    }
}

/// 计时器
extension Observable where Element: FloatingPoint {
    
    /*
     - parameter duration: 总时长
     - parameter interval: 时间间隔
     - parameter ascending: true 为顺数计时，false 为倒数计时
     */
    
    public static func timer(duration: RxTimeInterval = RxTimeInterval.infinity, interval: RxTimeInterval = 1, ascending: Bool = false, scheduler: SchedulerType = MainScheduler.instance)
        -> Observable<TimeInterval> {
            let count = (duration == RxTimeInterval.infinity) ? .max : Int(duration / interval) + 1
            return Observable<Int>.timer(0, period: interval, scheduler: scheduler)
                .map { TimeInterval($0) * interval }
                .map { ascending ? $0 : (duration - $0) }
                .take(count)
    }
}

/// 延迟
public func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
