//
//  J_LoginVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class J_LoginVC: J_BaseVC {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
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
        
        self.nameTF.rx.text .subscribe(onNext: { [weak self] (value) in
            guard var str = value else {
                return
            }
            if str.count > 10 {
                str = str.subToOffset(right: 10)
                self?.nameTF.text = str
            }
        }).disposed(by: self.disposeBag)
    }
    
    
    
    @IBAction func registerAction(_ sender: Any) {
        
        let registerVC = R.storyboard.main.j_RegisterVC()!
        registerVC.successClosure = {[weak self] (userName) in
            self?.nameTF.text = userName
        }
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let userName = nameTF.text else {
            J_HUD.show(text: "用户名不能为空")
            return
        }
        guard let password = passwordTF.text else {
            J_HUD.show(text: "密码不能为空")
            return
        }
        
        AVUser.logInWithUsername(inBackground: userName, password: password) { (user, error) in
            if user != nil {
                DispatchQueue.main.async {
                    J_HUD.show(text: "登陆成功")
                    let delegagte = UIApplication.shared.delegate as? AppDelegate
                    delegagte?.window?.makeKeyAndVisible()
                    delegagte?.window?.rootViewController = J_BaseTabBarVC.shareInstance
                }
            }else{
                J_HUD.show(text: "用户名或密码错误")
            }
        }
        
    }
    
    
    
}
