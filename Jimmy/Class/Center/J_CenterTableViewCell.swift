//
//  J_CenterTableViewCell.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/21.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import IQKeyboardManager
import RxSwift
class J_BaseTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    func updateValue(planM: J_PlanModel) {
        
    }
    
}

class J_PlanTopImageCell: J_BaseTableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    override func updateValue(planM: J_PlanModel) {
        if planM.topImage == nil {
            titleLab.isHidden = false
        }else{
            titleLab.isHidden = true
            imageV.image = UIImage(data: planM.topImage!)
        }
    }
    
}

class J_PlanConnectCell: J_BaseTableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var textView: IQTextView!
    
  
}

class J_PlanStartEndTimeCell: J_BaseTableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    func updateStartValue(planM: J_PlanModel) {
        titleLab.text = "请选择开始时间"
        timeLab.text = planM.startTime?.toString(format: .barShort)
    }
    func updateEndValue(planM: J_PlanModel) {
        titleLab.text = "请选择结束时间"
        timeLab.text = planM.endTime?.toString(format: .barShort)
    }
}
class J_PlanSettingCell: J_BaseTableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var connectLab: UILabel!
    
    @IBOutlet weak var switchBtn: UISwitch!
}

class J_PlanTitleCell: J_BaseTableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var inputTF: UITextField!
    
  
    
}
