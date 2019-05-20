//
//  EMBaseTabBarVC.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/2/11.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit

class J_BaseTabBarVC: UITabBarController {

    
    //入口
    static let shareInstance:J_BaseTabBarVC = {
        
        let instance = J_BaseTabBarVC()
        return instance
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerBtn = J_TabBar()
        self.setValue(centerBtn, forKey: "tabBar")
        
        initContent()
        
    }
    

    //初始化视图
    func initContent() {
                
        let homeNav = J_BaseNavigationVC(rootViewController: R.storyboard.main.j_HomeVC()!)
        let mineNav = J_BaseNavigationVC(rootViewController: J_MineVC())
        
        let navList = [homeNav, mineNav]
        viewControllers = navList
        
        let norImgNameList = [R.image.oPlan_homePlan_select_nor()!,R.image.oPlan_Mine_select_nor()!]
        let selImgNameList = [R.image.oPlan_homePlan_select()!,R.image.oPlan_Mine_select()!]
        let titleList = ["计划", "我的"]
        
        for (index,item) in navList.enumerated() {
            
            item.tabBarItem.title = titleList[index]
            item.tabBarItem.image = norImgNameList[index]
            item.tabBarItem.selectedImage = selImgNameList[index]
            
            item.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.hexString(color: "#CBCBCB"), .font: UIFont.systemFont(ofSize: 10)], for: .normal)
            item.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.hexString(color: "#F96E50"), .font: UIFont.systemFont(ofSize: 10)], for: .selected)
            
            // 更改背景颜色
//            item.tabBarController?.tabBar.backgroundColor = UIColor.white
//            item.tabBarController?.tabBar.isTranslucent = true
            // 分割线
//            item.tabBarController?.tabBar.shadowImage =  UIImage()
//            item.tabBarController?.tabBar.backgroundImage = UIImage()
        }
//        
//        let imageV = UIImageView(image: R.image.tabBar_bg()!)
//        
//        imageV.frame = CGRect(x: 0, y: -20, width: EMUI.Screen.Width, height: EMUI.Screen.TabbarH)
//        imageV.contentMode = .scaleAspectFill
//        self.tabBar.insertSubview(imageV, at: 0)
        
    }
    
}
