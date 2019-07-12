//
//  J_Client.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import URLNavigator
import IQKeyboardManager

class J_Client: NSObject {
    static var manger:J_Client =  {
        
        let instance = J_Client()
        return instance
    }()
    
    
    // 默认配置
    func config() {
        
//        let delegagte = UIApplication.shared.delegate as? AppDelegate
//        delegagte?.window?.makeKeyAndVisible()
//        delegagte?.window?.rootViewController = R.storyboard.main.j_TestVC()!
        
        handleSDK()
        handleWindow()
    }
    
    func handleSDK() {
        handleJpushSdk()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 80
        
        AVOSCloud.setApplicationId(J_Define.SDK.Cloud.AppID, clientKey: J_Define.SDK.Cloud.AppKey)
        AVOSCloud.setAllLogsEnabled(true)
    }
    
    func handleJpushSdk() {
        
   
        
        
    }
    
    
    func handleWindow() {
        let delegagte = UIApplication.shared.delegate as? AppDelegate
        delegagte?.window?.makeKeyAndVisible()
        delegagte?.window?.rootViewController = R.storyboard.main.j_LaunchScreenVC()!
    }
    
}

extension J_Client{
    
    
}
