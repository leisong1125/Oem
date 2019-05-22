//
//  J_PlanModel.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/22.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import SwiftDate
import RealmSwift

class J_PlanModel: Object {

    @objc dynamic var  title         : String    = ""
    @objc dynamic var  content       : String    = ""
    @objc dynamic var  startTime     : Date?     = nil{
        didSet{
            labelDate = startTime?.toString(format: .barYMd) ?? ""
        }
    }
    @objc dynamic var  endTime       : Date?     = nil
    @objc dynamic var  isPush        :  Bool     = true
    @objc dynamic var  topImage      :  Data?    = nil
    @objc dynamic var  labelDate     : String    = ""
}


class J_PlanReam: NSObject {
    
    // 入口
    static let manger:J_PlanReam = {
        
        let noti = J_PlanReam()
        return noti
    }()
    /// 删除
    func delePlan(model:J_PlanModel?) {
        
        if model == nil {
            return
        }
        guard let realm = try? Realm() else {
            return
        }
        realm.beginWrite()
        realm.delete(model!)
        try? realm.commitWrite()
    }
    
    /// 储存
    func savePlan(model:J_PlanModel?) {
        
        if model == nil {
            return
        }
        
        guard let realm = try? Realm() else {
            return
        }
        
        realm.beginWrite()
        realm.add(model!)
        
        try? realm.commitWrite()
    }
    
    /// 获取 系统消息
    func getPlan(label:String, succ: (_ planList:[J_PlanModel])->Void){
        let realm = try? Realm()
        guard let result = realm?.objects(J_PlanModel.self).filter("labelDate=%d",label) else { return }
        
        let modelList:[J_PlanModel] = result.map { (model) -> J_PlanModel in
            
            return model
        }
        let newList:[J_PlanModel] = modelList.reversed()
        succ(newList)
    }
}
