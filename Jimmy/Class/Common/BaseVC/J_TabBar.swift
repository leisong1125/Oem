//
//  EMTabBar.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/2/11.
//  Copyright © 2019年 zhaofan. All rights reserved.
//

import UIKit
import SnapKit

class J_TabBar: UITabBar {

        
    lazy var middleBtn: UIButton = {
        let sendBtn = UIButton(type: UIButton.ButtonType.custom)
        sendBtn.setImage(R.image.oPlan_CreatePlan()!, for: .normal)
        sendBtn.addTarget(self, action: #selector(didClickPublishBtn), for: .touchUpInside)
        return sendBtn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.middleBtn)
        self.middleBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.centerX.equalTo(J_UI.Screen.Width/2.0)
            make.centerY.equalTo(10)
        }
        
        var itemX: CGFloat = 0.0
        let itemY: CGFloat = 0.0
        let itemH: CGFloat  = self.bounds.size.height
        let ddd: CGFloat = CGFloat(self.items!.count)
        // 算出每一个占据的宽度 加上了加号 Button 的位置
        let itemW: CGFloat = self.bounds.size.width / (ddd + 1)
        
        var itemCurrent: CGFloat = 0
        for item in self.subviews {
            if NSStringFromClass(item.classForCoder) == "UITabBarButton" {
                
                if itemCurrent == 1 { itemCurrent = 2 }
                
                itemX = itemCurrent * itemW
                item.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                itemCurrent += 1
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            let newPoint: CGPoint = self.convert(point, to: self.middleBtn)
            if self.middleBtn.point(inside: newPoint, with: event)
            {
                return self.middleBtn
            }else
            {
                return super.hitTest(point, with: event)
            }
        }else{
            return super.hitTest(point, with: event)
        }
    }
    
    
    
    @objc func didClickPublishBtn() {
        // mark -
        let vc = R.storyboard.main.j_CenterVC()!
        J_App.currentRootNav().pushViewController(vc, animated: true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
