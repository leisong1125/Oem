//
//  J_LaunchScreenVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class J_LaunchScreenVC: J_BaseVC {

    
    var alertVC : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delay(2) { [weak self] in
            self?.handleWindow()
        }
    }
    func handleWindow() {
        J_Check.handleNetWork(succ: { [weak self](Om) in
            self?.succAcion(om: Om)
        }) { [weak self] in
            self?.failAction()
        }
    }
    
    func succAcion(om: J_OModel?) {
        let delegagte = UIApplication.shared.delegate as? AppDelegate
        delegagte?.window?.makeKeyAndVisible()
        guard let Om = om else {
            delegagte?.window?.rootViewController = J_BaseTabBarVC.shareInstance
            return
        }
        alertVC?.dismiss(animated: true, completion: nil)
        if Om.plan_open_status == true {
            delegagte?.window?.rootViewController = J_WKWebViewVC.getWkWebView(om: Om)
        }else{
            delegagte?.window?.rootViewController = J_BaseTabBarVC.shareInstance
        }
    }
    
    func failAction() {
        alertVC =  J_Alert.show(connect: "当前网络异常，请重新操作") { [weak self] in
            self?.handleWindow()
        }
        self.present(alertVC!, animated: true, completion: nil)
    }


}
