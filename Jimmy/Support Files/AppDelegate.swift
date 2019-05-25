//
//  AppDelegate.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import AdSupport
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let entity = JPUSHRegisterEntity()
        
        if #available(iOS 12.0, *){
            let options : JPAuthorizationOptions = [JPAuthorizationOptions.alert, JPAuthorizationOptions.badge, JPAuthorizationOptions.sound, JPAuthorizationOptions.providesAppNotificationSettings]
            entity.types = Int(options.rawValue)
        }else{
            let options : JPAuthorizationOptions = [JPAuthorizationOptions.alert, JPAuthorizationOptions.badge, JPAuthorizationOptions.sound]
            entity.types = Int(options.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        JPUSHService.setup(withOption: launchOptions, appKey: J_Define.SDK.JPush.AppKey, channel: J_Define.SDK.JPush.Channel, apsForProduction: J_Define.SDK.JPush.isProduction, advertisingIdentifier: advertisingId)
        
        J_Client.manger.config()
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }
}

extension AppDelegate: JPUSHRegisterDelegate{
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        completionHandler()
    }
    
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let str = notification.request.content.title
        print(" 标题 == \(str)")
        
        let options : UNNotificationPresentationOptions = [.badge, .sound, .alert]
        completionHandler(Int(options.rawValue))
    }
    
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
        let str = notification?.request.content.title ?? ""
        print(" 标题 == \(str)")
    }

    // ios 7 以上
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        completionHandler(.newData)
    }
}

