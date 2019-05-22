//
//  J_NavMap.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import URLNavigator

let navigator = NavigationMap()


enum J_VCUrl: String {
    
    //登录
    case centerVC = "jimmyPush://centerVC"
}


class NavigationMap: Navigator {
    
    static func initialize() {
        //  userLogin
        navigator.register(J_VCUrl.centerVC.rawValue) { (url, valus, content) -> UIViewController? in
            let login = R.storyboard.main.j_CenterVC()!
//            let loginNavi = BaseNavigationVC(rootViewController: login)
            return login
        }
    }
    
    
    static func push(url: URLConvertible, context: Any? = nil,  animated: Bool = true) -> UIViewController?{
        let vc = navigator.push(url, context: context, from: nil, animated: animated)
        return vc
    }
    
    static func present(url: URLConvertible, context: Any? = nil, wrap: UINavigationController.Type? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController?{
        
        let vc = navigator.present(url, context: context, wrap: wrap, animated: animated, completion: completion)
        return vc
    }
}
