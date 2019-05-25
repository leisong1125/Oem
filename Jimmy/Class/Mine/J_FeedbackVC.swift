//
//  J_FeedbackVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import IQKeyboardManager

class J_FeedbackVC: J_BaseVC {
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var textView: IQTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func submitAction(_ sender: Any) {
        if phoneTF.text?.count ?? 0 <= 0 {
            J_HUD.show(text: "联系方式不能为空")
            return
        }
        
        if textView.text.count <= 0 {
            J_HUD.show(text: "内容不能为空")
            return
        }
        J_HUD.show(text: "提交成功")
        navigationController?.popViewController(animated: true)
    }
    
}
