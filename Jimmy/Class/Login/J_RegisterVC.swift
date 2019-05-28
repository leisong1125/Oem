//
//  J_RegisterVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class J_RegisterVC: J_BaseVC {

    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var aginPasswordTF: UITextField!
    
    var successClosure : ((_ userName: String)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initRX()
    }
    
    func initRX() {
        self.passwordTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 12 {
                str = str.subToOffset(right: 12)
                self?.passwordTF.text = str
            }
        }).disposed(by: self.disposeBag)
        
        self.aginPasswordTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 12 {
                str = str.subToOffset(right: 12)
                self?.aginPasswordTF.text = str
            }
        }).disposed(by: self.disposeBag)
        
        self.userNameTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 10 {
                str = str.subToOffset(right: 10)
                self?.userNameTF.text = str
            }
        }).disposed(by: self.disposeBag)
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        
        guard let userName = userNameTF.text else {
            J_HUD.show(text: "用户名不能为空")
            return
        }
        guard let password = passwordTF.text else {
            J_HUD.show(text: "密码不能为空")
            return
        }
        
        guard let aginPassword = aginPasswordTF.text else {
            J_HUD.show(text: "密码不能为空")
            return
        }
        
        if password != aginPassword {
            J_HUD.show(text: "两次密码不一致")
        }
        
        let user = AVUser()
        user.username = userName
        user.password = password
        
        user.signUpInBackground { [weak self](result, err) in
            if result == true {
                self?.successClosure?(userName)
                self?.navigationController?.popViewController(animated: true)
            }else if (err?._code == 202) {
                J_HUD.show(text: "用户名已存在")
            }else{
                J_HUD.show(text: "注册失败")
            }
        }
    }
    
}
