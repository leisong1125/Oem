//
//  J_Client.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import URLNavigator

class J_Client: NSObject {
    static var manger:J_Client =  {
        
        let instance = J_Client()
        return instance
    }()
    
    
    // 默认配置
    func config() {
        
        NavigationMap.initialize()
        
        let delegagte = UIApplication.shared.delegate as? AppDelegate
        delegagte?.window?.makeKeyAndVisible()
        delegagte?.window?.rootViewController = J_BaseTabBarVC.shareInstance
    }
    
    
}
