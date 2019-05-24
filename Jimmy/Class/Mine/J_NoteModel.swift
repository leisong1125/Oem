//
//  J_NoteModel.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import SwiftDate
import RealmSwift

class J_NoteModel: Object {

    @objc dynamic var  content       : String    = ""
    @objc dynamic var  startTime     : Date?     = nil{
        didSet{
            dayLabel   = startTime?.toString(format: .barYMd) ?? ""
            monthLabel = startTime?.month.toString() ?? ""
            yearLabel  = startTime?.year.toString() ?? ""
        }
    }
    @objc dynamic var  dayLabel      : String    = "" // 2019-10-10
    @objc dynamic var  monthLabel    : String    = "" // 10-10
    @objc dynamic var  yearLabel     : String    = "" // 2019
}

class J_DiaryModel: Object {
    
    @objc dynamic var  weather       : String    = "" //天气
    @objc dynamic var  mood          : String    = "" // 心情
    @objc dynamic var  content       : String    = "" // 日记
    @objc dynamic var  startTime     : Date?     = nil{
        didSet{
            dayLabel   = startTime?.toString(format: .barYMd) ?? ""
            monthLabel = startTime?.month.toString() ?? ""
            yearLabel  = startTime?.year.toString() ?? ""
        }
    }
    @objc dynamic var  dayLabel      : String    = "" // 2019-10-10
    @objc dynamic var  monthLabel    : String    = "" // 10-10
    @objc dynamic var  yearLabel     : String    = "" // 2019
}


class J_NoteReam: NSObject {
    
    // 入口
    static let manger:J_NoteReam = {
        
        let noti = J_NoteReam()
        return noti
    }()
    /// 删除
    func deleNote(model:J_NoteModel?) {
        
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
    
    func change(model: J_NoteModel?) {
        
        if model == nil {
            return
        }
        guard let realm = try? Realm() else {
            return
        }
        
        try? realm.write {
            model?.content = model!.content
        }
    }
    
    /// 储存
    func saveNote(model:J_NoteModel?) {
        
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
    func getNote(succ: (_ NoteList:[J_NoteModel])->Void){
        let realm = try? Realm()
        guard let result = realm?.objects(J_NoteModel.self) else { return }
        
        let modelList:[J_NoteModel] = result.map { (model) -> J_NoteModel in
            
            return model
        }
        let newList:[J_NoteModel] = modelList.reversed()
        succ(newList)
    }
}

class J_DiaryReam: NSObject {
    
    // 入口
    static let manger:J_DiaryReam = {
        
        let noti = J_DiaryReam()
        return noti
    }()
    /// 删除
    func deleDiary(model:J_DiaryModel?) {
        
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
    func saveDiary(model:J_DiaryModel?) {
        
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
    func getDiary(succ: (_ NoteList:[J_DiaryModel])->Void){
        let realm = try? Realm()
        guard let result = realm?.objects(J_DiaryModel.self) else { return }
        
        let modelList:[J_DiaryModel] = result.map { (model) -> J_DiaryModel in
            
            return model
        }
        let newList:[J_DiaryModel] = modelList.reversed()
        succ(newList)
    }
}
