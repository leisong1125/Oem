//
//  J_UI.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

struct J_UI{
    
    struct Screen {
        
        static let NavH:        CGFloat = UIApplication.shared.statusBarFrame.height + 44
        static let titleViewH:  CGFloat =  44
        static let TabbarH:     CGFloat =  J_UI.Screen.IphoneX ? (49.0 + 34.0) : 49.0
        
        static let TabbarSafeBottomMargin:     CGFloat =  J_UI.Screen.IphoneX ? 34.0 : 0.0
        static let StatusbarH:  CGFloat = UIApplication.shared.statusBarFrame.height
        static let Width:       CGFloat = UIScreen.main.bounds.size.width
        static let Height:      CGFloat = UIScreen.main.bounds.size.height
        static let Bounds:      CGRect  = UIScreen.main.bounds
        static let IphoneX:     Bool    =  UIApplication.shared.statusBarFrame.height != 20
    }
    
    
    
    struct Color {
        
        /// 主色调
        static let primary       =   UIColor.hexString(color: "#F96E50")
        /// 导航 主色调
        static let nav_primary   =  UIColor.hexString(color: "#5C5757")
        /// 按钮 不可点击
        static let btn_noSelect  =  UIColor.hexString(color: "#C5C5C5")
        /// 文本 提示占位 浅灰色
        static let lightGray    =   UIColor.hexString(color: "#C2C2C2")
        /// 文本 灰色
        static let textGray     =   UIColor.hexString(color: "#CCCCCC")
        /// 文本 蓝色
        static let textBlue     =   UIColor.hexString(color: "#45B5FA")
        /// 按钮图标灰色
        static let gray         =   UIColor.hexString(color: "#CCCCCC")
        /// 背景黑色
        static let bgGray       =   UIColor.hexString(color: "#F5F5F5")
        /// 文字黑色
        static let black        =   UIColor.hexString(color: "#333333")
        /// 文字浅黑
        static let lightBlack   =   UIColor.hexString(color: "#666666")
        /// toast 背景色
        static let toastBlack   =   UIColor.hexString(color: "#161942")
        /// 白色
        static let white        =   UIColor.hexString(color: "#FFFFFF")
        /// navBlack
        static let navBlack     =   UIColor.hexString(color: "#333333")
        /// 充值标签
        static let rechargeColor =  UIColor.hexString(color: "#45B5FA")
        
    }
}
