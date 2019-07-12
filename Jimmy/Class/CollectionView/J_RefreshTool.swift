//
//  J_RefreshTool.swift
//  Jimmy
//
//  Created by zhaofan on 2019/6/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import MJRefresh

class J_RefreshTool: NSObject {

    // 刷新头 动画
    class func header(closure:@escaping (()->Void)) ->DIYRefreshHeader {
        
        let header = DIYRefreshHeader.init {
            
            closure()
        }
        header?.isAutomaticallyChangeAlpha = true
        
        return header!
    }
    
    // 刷新尾部
    class func footer(closure:@escaping (()->Void)) ->DIYRefreshBackFooter {
        
        let footer = DIYRefreshBackFooter.init(refreshingBlock: {
            closure()
        })
        
        footer?.isAutomaticallyChangeAlpha = true
        return footer!
    }
}

class DIYRefreshHeader: MJRefreshHeader {
    
    var titleLab  : UILabel?
    
    /// 初始化
    override func prepare() {
        super.prepare()
        
        mj_h = 50
        
        titleLab = UILabel()
        titleLab?.textColor = UIColor.black
        titleLab?.font = UIFont.systemFont(ofSize: 14)
        titleLab?.textAlignment = .center
        addSubview(titleLab!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        titleLab?.frame = CGRect(x: 0, y: 15, width: self.frame.size.width, height: 20)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                titleLab?.isHidden = false
                titleLab?.text = "下拉回到商品详情"
            case .pulling:
                titleLab?.isHidden = false
                titleLab?.text = "松开回到商品详情"
            case .refreshing:
                titleLab?.isHidden = false
                titleLab?.text = "松开回到商品详情"
            default:
                titleLab?.isHidden = true
            }
        }
    }
    
}

class DIYRefreshBackFooter: MJRefreshBackFooter {
    
    var titleLab  : UILabel?
    
    
    /// 初始化
    override func prepare() {
        super.prepare()
        
        mj_h = 50
        
        titleLab = UILabel()
        titleLab?.textColor = UIColor.black
        titleLab?.font = UIFont.systemFont(ofSize: 14)
        titleLab?.textAlignment = .center
        addSubview(titleLab!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        titleLab?.frame = CGRect(x: 0, y: 15, width: self.frame.size.width, height: 20)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                titleLab?.isHidden = false
                titleLab?.text = "上拉查看图文"
            case .pulling:
                titleLab?.isHidden = false
                titleLab?.text = "松开查看图文"
            case .refreshing:
                titleLab?.isHidden = false
                titleLab?.text = "松开查看图文"
            default:
                titleLab?.isHidden = true
            }
        }
    }
    
}
