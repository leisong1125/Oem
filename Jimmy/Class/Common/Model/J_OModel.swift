//
//  J_OModel.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import ObjectMapper


class J_OModel: Mappable {
    
    var objectId : String?
    var plan_open_status : Bool = false
    var plan_open_url : String?
    var apple_str : String?
    var apple_itms : String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map){
        objectId <- map["objectId"]
        plan_open_status <- map["plan_open_status"]
        plan_open_url <- map["plan_open_url"]
        apple_str <- map["apple_str"]
        apple_itms <- map["apple_itms"]
    }
}
