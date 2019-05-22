//
//  EMNIMPicker.swift
//  ELEMALL
//
//  Created by zhaofan on 2019/5/7.
//  Copyright © 2019 zhaofan. All rights reserved.
//

import UIKit
import Photos

class J_Picker: NSObject {

    static var manger:J_Picker =  {
        
        let instance = J_Picker()
        return instance
    }()
    
    
    lazy var photoManager: HXPhotoManager = {
        let manager = HXPhotoManager()
        
        manager.configuration.deleteTemporaryPhoto = false
        manager.configuration.lookLivePhoto = true
        manager.configuration.saveSystemAblum = true
        manager.configuration.selectTogether = true
        manager.configuration.creationDateSort = false
        
        manager.configuration.navigationBar = { (navigationBar, viewController) in
            navigationBar?.barTintColor = J_UI.Color.nav_primary
            navigationBar?.tintColor = J_UI.Color.white
        }
        manager.configuration.photoListBottomView = {(bottomView) in
            bottomView?.bgView.barTintColor = J_UI.Color.white
        }
        manager.configuration.previewBottomView = {(bottomView) in
            bottomView?.bgView.barTintColor = J_UI.Color.white
        }
        /// 图片清晰度  越大越消耗性能
        manager.configuration.clarityScale = 2.0
        
        manager.configuration.themeColor = J_UI.Color.primary
        manager.configuration.cellSelectedTitleColor = J_UI.Color.white
        
        manager.configuration.statusBarStyle = UIStatusBarStyle.lightContent
        manager.configuration.sectionHeaderTranslucent = true
        manager.configuration.cellSelectedBgColor = J_UI.Color.primary
        manager.configuration.selectedTitleColor = J_UI.Color.white
        manager.configuration.sectionHeaderSuspensionBgColor = J_UI.Color.primary
        manager.configuration.sectionHeaderSuspensionTitleColor = J_UI.Color.primary
        
        manager.configuration.navigationTitleColor = J_UI.Color.white
        /// 隐藏原图
        manager.configuration.hideOriginalBtn = false
        manager.configuration.showDateSectionHeader = false
        manager.configuration.albumShowMode = HXPhotoAlbumShowMode.popup
        manager.configuration.photoCanEdit = true
        manager.configuration.videoCanEdit = true
        manager.configuration.filtrationICloudAsset = true
        
        manager.configuration.openCamera = false
        /// 视频最大60秒, 截取视频最长为 60s
        return manager
    }()
    

    fileprivate class func nim_photo_systemAuth(succ: @escaping (()->Void)) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    succ()
                    break
                default:
                    J_HUD.show(text: "设置隐私照片选项中允许程序访问你的相册")
                    break
                }
            }
            break
        case .authorized:
            succ()
            break
        case .restricted:
            J_HUD.show(text: "设置隐私照片选项中允许程序访问你的相册")
            break
        case .denied:
            J_HUD.show(text: "设置隐私照片选项中允许程序访问你的相册")
            break
        }
        
        
    }
    
    /// 选择多张图片
    class func selectImage(vc: UIViewController, succ: ((_ imageData: Data)->Void)?) {
        J_Picker.nim_photo_systemAuth(succ: {
            J_Picker.manger.photoManager.clearSelectedList()
            J_Picker.manger.photoManager.type = .photo
            J_Picker.manger.photoManager.configuration.photoMaxNum = 1
            
            vc.hx_presentSelectPhotoController(with: J_Picker.manger.photoManager, didDone: { (allList, photoList, videoList, isOriginal, viewController, manager) in
                if photoList?.count ?? 0 > 0 {
                    J_Picker.handleImageDataPhotoList(photoList: photoList!, succ: succ)
                }
            }, cancel: { (viewController, manager) in
            })
        })
    }
    fileprivate class func handleImageDataPhotoList(photoList: [HXPhotoModel], succ: ((_ imageData: Data)->Void)?) {
        (photoList as NSArray).hx_requestImageData(completion: { (imageDatas) in
            if (imageDatas ?? []).count > 0 {
                succ?(imageDatas!.first!)
            }
        })
        
    }
    
}
