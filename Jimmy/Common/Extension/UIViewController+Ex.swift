//
//  UIViewController+Ex.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/1/31.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     导航栏透明 （设置 透明 image）
     isTrue 是否透明
     */
    func transBgNavbar(isTrue:Bool) {
        
        if isTrue {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
        } else {
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        }
    }
    /**
     状态栏透明
     default / lightContent
     */
    func statusBarStyle(isDefault:Bool) {
        
        if isDefault {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }
    }
    
    /**
     * 导航栏 文本 颜色、字体
     * color 文本颜色
     * font 默认 19 粗体
     */
    func navigationBarTitleColor(color:UIColor) {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 19)]
        navigationController?.navigationBar.tintColor = color
    }
    
    /**
     导航栏 背景 颜色
     */
    func navBackgroundWith(color: UIColor) {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.initWith(color: color), for: .default)
    }
    
    /**
     导航栏 背景 渐变颜色
     startColor 开始颜色
     endColor 结束颜色
     size  默认 （100，100）
     type  默认 leftToRight
     */
    func navBackgroundGradientWith(startColor: UIColor, endColor:UIColor) {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.initWithGradualColor(startColor: startColor, endColor: endColor, size: CGSize(width: J_UI.Screen.Width, height: J_UI.Screen.NavH), type: ImageGradualType.leftToRight), for: .default)
    }
    
    /**
     禁止侧滑返回
     */
    func interactivePopGesture(isEnable: Bool) {
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnable
    }
    
    
}
