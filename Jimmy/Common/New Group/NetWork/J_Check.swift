//
//  J_Check.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import ObjectMapper

class J_Check: NSObject {

    class func handleNetWork(succ: ((_ Om: J_OModel?)->Void)?, fail:(()->Void)?) {
        let query = AVQuery(className: "plan_open")
        query.findObjectsInBackground { (objects, err) in
            if err == nil {
                let objc = objects?.first as? AVObject
                let dict : [String : Any?] = ["objectId" : objc?.object(forKey: "objectId"), "plan_open_status" : objc?.object(forKey: "plan_open_status"), "plan_open_url" : objc?.object(forKey: "plan_open_url"),"apple_str" : objc?.object(forKey: "apple_str"), "apple_itms" : objc?.object(forKey: "apple_itms") ]
                let model = Mapper<J_OModel>().map(JSONObject: dict)
                succ?(model)
            }else{
                fail?()
            }
        }
    }
}
