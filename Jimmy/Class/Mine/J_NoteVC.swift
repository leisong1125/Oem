//
//  J_NoteVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IQKeyboardManager

class J_NoteVC: J_BaseVC {

    var noteM : J_NoteModel?
    
    @IBOutlet weak var textView: IQTextView!
    @IBOutlet weak var dateLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleRx()
        initData()
        if noteM == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(creatAction))
        }
    }
    
    func handleRx() {
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
        if noteM == nil {
            navigationItem.title = "创建便签"
            dateLab.text = Date().toString(format: FormatStyle.barYMd)
        }else{
            navigationItem.title = "详情"
            textView.text = noteM!.content
            dateLab.text  = noteM?.dayLabel

            textView.isEditable = false
        }
    }
    

    @objc func creatAction() {
        if textView.text.count <= 0 {
            navigationController?.popViewController(animated: true)
            return
        }
        let noteModel = J_NoteModel()
        noteModel.content = textView.text
        noteModel.startTime = Date()
        J_NoteReam.manger.saveNote(model: noteModel)
        
        navigationController?.popViewController(animated: true)
    }
}
