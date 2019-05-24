//
//  J_DiaryVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import IQKeyboardManager

class J_DiaryVC: J_BaseVC {

    @IBOutlet weak var textView: IQTextView!
    @IBOutlet weak var stateInputTF: UITextField!
    @IBOutlet weak var waterInputTF: UITextField!
    @IBOutlet weak var dateTitleLab: UILabel!
    
    var diaryM : J_DiaryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleRx()
        initData()
        if diaryM == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(creatAction))
        }
    }
    
    func handleRx() {
        self.waterInputTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 10 {
                str = str.subToOffset(right: 10)
                self?.waterInputTF.text = str
            }
        }).disposed(by: self.disposeBag)
        self.stateInputTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 10 {
                str = str.subToOffset(right: 10)
                self?.stateInputTF.text = str
            }
        }).disposed(by: self.disposeBag)
        
        self.textView.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 300 {
                str = str.subToOffset(right: 300)
                self?.textView.text = str
            }
        }).disposed(by: self.disposeBag)
        
    }
    
    
    func initData() {
        if diaryM == nil {
            navigationItem.title = "写日记"
            dateTitleLab.text = "日期:" + Date().toString(format: FormatStyle.barYMd)
        }else{
            navigationItem.title = "日记详情"
            dateTitleLab.text = "日期:" + (diaryM!.startTime?.toString(format: FormatStyle.barYMd) ?? "")
            waterInputTF.text = diaryM!.weather
            stateInputTF.text  = diaryM!.mood
            textView.text     = diaryM!.content
            
            waterInputTF.isEnabled = false
            stateInputTF.isEnabled = false
            textView.isEditable = false
        }
    }
    
    
    @objc func creatAction() {
        if textView.text.count <= 0 || stateInputTF.text?.count ?? 0 <= 0 || waterInputTF.text?.count ?? 0 <= 0{
            navigationController?.popViewController(animated: true)
            return
        }
        let diaryModel = J_DiaryModel()
        diaryModel.content = textView.text
        diaryModel.startTime = Date()
        diaryModel.mood = stateInputTF.text ?? ""
        diaryModel.weather = waterInputTF.text ?? ""
        
        J_DiaryReam.manger.saveDiary(model: diaryModel)
        navigationController?.popViewController(animated: true)
    }
}
