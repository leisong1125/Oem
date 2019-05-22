//
//  J_HUD.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import SVProgressHUD

struct J_HUD{
    
    /// 提示 带有 提示图标
    ///
    /// - Parameter text: 显示文本
    static func showWithLogo(info:String) {
        
        setSvprogressHUD()
        SVProgressHUD.showInfo(withStatus: info)
    }
    
    /// 显示toast 纯文字
    ///
    /// - Parameter text: 显示文本
    static func show(text:String) {
        
        OperationQueue.main.addOperation {
            setSvprogressHUD()
            //            SVProgressHUD.setMaximumDismissTimeInterval(1.5)
            SVProgressHUD.dismiss(withDelay: 1.5)
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.showInfo(withStatus: text)
            //            SVProgressHUD.setInfoImage(UIImage())
            SVProgressHUD.setImageViewSize(CGSize(width: 0, height: 0))
        }
        
    }
    
    
    /// 显示 进度条
    ///
    /// - Parameter pro: 0.xx
    static func show(progress:Float) {
        
        OperationQueue.main.addOperation {
            setSvprogressHUD()
            let prostr = (progress * 100.0).toString() + "%"
            SVProgressHUD.showProgress(progress, status: prostr)
        }
        
    }
    
    /// 显示等待状态 默认 系统菊花，text 可选
    ///
    /// - Parameter str: 文本
    static func show(status:String?) {
        
        OperationQueue.main.addOperation {
            
            setSvprogressHUD()
            //                SVProgressHUD.dismiss(withDelay: 60)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    /// 消失
    static func dismiss() {
        
        OperationQueue.main.addOperation {
            SVProgressHUD.dismiss()
        }
    }
    
    // 设置默认样式
    fileprivate static func setSvprogressHUD() {
        
        SVProgressHUD.setCornerRadius(8)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor(UIColor.hexString(color: "#161942"))
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setMinimumSize(CGSize(width: 80, height: 60))
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
    
    /// 成功
    ///
    /// - Parameter title: title
    static func show(success title:String) {
        
        setSvprogressHUD()
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.show(R.image.hud_suc()!, status: title)
        SVProgressHUD.setImageViewSize(CGSize(width: 28, height: 28))
        
    }
    /// 失败
    ///
    /// - Parameter title: title
    static func show(error title:String) {
        
        OperationQueue.main.addOperation {
            setSvprogressHUD()
            SVProgressHUD.setMaximumDismissTimeInterval(1.5)
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.show(R.image.hud_error()!, status: title)
            SVProgressHUD.setImageViewSize(CGSize(width: 28, height: 28))
        }
    }
    
    /// 显示黑色遮照
    ///
    /// - Parameter title: title
    static func showMaskStatus(title:String?) {
        
        OperationQueue.main.addOperation {
            setSvprogressHUD()
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show(withStatus: title)
        }
    }
}
