//
//  J_Alert.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

struct J_Alert {

    /// 显示弹窗 和 OK
    ///
    /// - Parameters:
    ///   - title: 显示标题 可为nil
    ///   - desc: 内容
    ///   - trueCol 回调
    static func show(connect:String?, trueCol:(()->Void)?) ->UIAlertController {
        
        let vc = UIAlertController.init(title: nil, message: connect, preferredStyle: .alert)
        let btn = UIAlertAction.init(title: "确定", style: .default) { (alert) in
            if trueCol != nil {
                trueCol!()
            }
        }
        vc.addAction(btn)
        return vc
    }
    
    
    /// 确认
    static func show(title:String?, content:String?,trueTitle:String?,cancelTitle:String?,trueCol:(()->Void)?){
        
        let vc = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelTitle ?? "取消", style: .cancel) { (alert) in
        }
        
        let sure = UIAlertAction(title: trueTitle ?? "确定", style: .default ) { (alert) in
            if trueCol != nil {
                trueCol!()
            }
        }
        vc.addAction(cancel)
        vc.addAction(sure)
        
        J_App.currentVC()?.present(vc, animated: true, completion: nil)
    }
}


