//
//  J_CenterVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import SwiftDate

class J_CenterVC: J_BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var planModel : J_PlanModel = J_PlanModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        planModel.startTime = Date().afterMinu(minu: 30)
        planModel.endTime   = Date().afterMinu(minu: 30)
        
        
        navigationItem.title = "创建计划"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveAction))
    }
    
    @objc func saveAction() {
        
        if self.planModel.topImage == nil {
            J_HUD.show(text: "请选择图片")
            return
        }
        if self.planModel.title.count <= 0 {
            J_HUD.show(text: "请输入标题")
            return
        }
        if self.planModel.content.count <= 0  {
            J_HUD.show(text: "请输入内容")
            return
        }
        let tem = planModel.startTime! - planModel.endTime!
        if tem > 0 {
            J_HUD.show(text: "开始时间必须早于结束时间")
            return
        }
        
        J_PlanReam.manger.savePlan(model: planModel)
        navigationController?.popViewController(animated: true)
    }

    
    func creatNotifacation() {
        if !planModel.isPush {
            return
        }
        
        let localNotification = UILocalNotification()
        localNotification.alertBody = planModel.title
        localNotification.alertAction = planModel.title
        
        let second = planModel.endTime! - planModel.startTime!
        if second == 0 {
            localNotification.fireDate = Date(timeIntervalSinceNow: 10)
        }else if second > 0 {
            localNotification.fireDate = Date(timeIntervalSinceNow: second)
        }else{
            return
        }
        
        localNotification.applicationIconBadgeNumber = 0
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        let interval = planModel.startTime!.timeIntervalSince1970*1000
        let intervalString = "\(interval)"
        let infoDic = ["id" : intervalString]
        localNotification.userInfo = infoDic
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    
    
    
    @objc func switchAction(sender: UISwitch) {
        self.planModel.isPush = sender.isOn
    }
    
    
}

extension J_CenterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 80
        case 2:
            return 160
        case 4, 3:
            return 80
        default:
            return 80
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let imageTopCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanTopImageCell, for: indexPath)!
            imageTopCell.updateValue(planM: planModel)
            return imageTopCell
        }else if indexPath.row == 1 {
            let titleTextCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanTitleCell, for: indexPath)!
            titleTextCell.inputTF.rx.text .subscribe(onNext: { [weak self] (value) in
                guard var str = value else {
                    return
                }
                if str.count > 12 {
                    str = str.subToOffset(right: 12)
                    titleTextCell.inputTF.text = str
                }
                self?.planModel.title = str
            }).disposed(by: titleTextCell.disposeBag)
            
            return titleTextCell
            
        }else if indexPath.row == 2 {
            let connectTextCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanConnectCell, for: indexPath)!
            connectTextCell.textView.rx.text .subscribe(onNext: { [weak self] (value) in
                guard var str = value else {
                    return
                }
                if str.count > 50 {
                    str = str.subToOffset(right: 50)
                    connectTextCell.textView.text = str
                }
                self?.planModel.content = str
            }).disposed(by: connectTextCell.disposeBag)
            return connectTextCell
            
        }else if indexPath.row == 3 {
            let statrTimeCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanStartEndTimeCell, for: indexPath)!
            statrTimeCell.updateStartValue(planM: planModel)
            return statrTimeCell
        }else if indexPath.row == 4 {
            let endTimeCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanStartEndTimeCell, for: indexPath)!
            endTimeCell.updateEndValue(planM: planModel)
            return endTimeCell
        }else {
            let settingCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_PlanSettingCell, for: indexPath)!
            settingCell.switchBtn.addTarget(self, action: #selector(switchAction(sender:)), for: UIControl.Event.editingChanged)
            return settingCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            J_Picker.selectImage(vc: self) { [weak self](imagData) in
                self?.planModel.topImage = imagData
                self?.tableView.reloadData()
            }
        }else if indexPath.row == 3 {
            J_PickerView.popView {[weak self] (date) in
                self?.planModel.startTime = date
                self?.tableView.reloadData()
            }
        }else if indexPath.row == 4 {
            J_PickerView.popView { [weak self](date) in
                self?.planModel.endTime = date
                self?.tableView.reloadData()
            }
        }
    }
    
    
}
