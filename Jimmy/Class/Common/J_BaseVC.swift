//
//  EMBaseVC.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/2/11.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit

class J_BaseVC: UIViewController {

    fileprivate var backImage: UIImage?
    
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        return UIBarButtonItem(image: backImage ?? R.image.nav_back() , style: .plain, target: target, action:action)
    }
    
    /// rt 自定义 返回按钮 可侧滑
    func setRt_backImage(img: UIImage) {
        backImage = img
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /**
         设置 默认
         导航栏白色
         状态栏 黑色
         导航栏 文本颜色 黑色
         */
        transBgNavbar(isTrue: false)
        statusBarStyle(isDefault: false)
        navBackgroundGradientWith(startColor: UIColor.hexString(color: "#FCBE34"), endColor: UIColor.hexString(color: "#F96E50"))
        navigationBarTitleColor(color: J_UI.Color.white)
        
    }
    
    
    // 设置tableview。scrolview 透明时 顶部是否上移
    func setScrollViewContentMoving(scrollView:UIScrollView) {
        
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
            edgesForExtendedLayout = .top
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
            edgesForExtendedLayout = .top
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
