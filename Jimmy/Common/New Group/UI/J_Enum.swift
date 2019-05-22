//
//  J_Enum.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

enum ImageGradualType {
    case leftToRight            // 左右
    case topToBottom            // 上下
    case leftTopCornerToR     // 对角线 左上 右下
    case leftBottomCornerToR    // 对角线 左下 右上
}

enum FormatStyle:String {
    
    case defaultStyle        = "yyyy.MM.dd HH:mm:ss"
    case all                 = "yyyy-MM-dd HH:mm:ss"
    case barShort            = "yyyy-MM-dd HH:mm"
    case dotShort            = "yyyy.MM.dd HH:mm"
    case barYMd              = "yyyy-MM-dd"
    case dotYMd              = "yyyy.MM.dd"
    case barMdHm             = "MM.dd HH:mm"
    case dotMdHm             = "MM-dd HH:mm"
    case chineseMdHm         = "MM月dd日 HH:mm"
    case timeAll             = "HH:mm:ss"
    case timeShort           = "HH:mm"
    case chineseBarShort        = "yyyy年MM月dd日  ahh:mm"
}
