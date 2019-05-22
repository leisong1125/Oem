//
//  J_PickerView.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/21.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import GKCover

class J_PickerView: UIView {

    var dateClousure : ((_ date: Date?)->Void)?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancelAction(_ sender: Any) {
        
        GKCover.hide {
            
        }
        
    }
    @IBAction func okAction(_ sender: Any) {
        GKCover.hide { [weak self] in
            self?.dateClousure?(self?.datePicker.date)
        }
    }
    
    
    class func popView(clousure: ((_ date: Date?)->Void)?) {
        
        let popView = R.nib.j_BaseView.firstView(owner: nil)!
        popView.frame = CGRect(x: 0, y: 0, width: J_UI.Screen.Width, height: 349)
        popView.dateClousure = clousure
        popView.datePicker.minimumDate = Date().afterMinu(minu: 30)
        GKCover.cover(from: J_App.window(), contentView: popView, style: .translucent, showStyle: .bottom, showAnimStyle: .bottom, hideAnimStyle: .bottom, notClick: false)
    }
}
