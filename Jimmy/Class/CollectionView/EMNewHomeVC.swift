//
//  EMNewHomeVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import SnapKit

class EMNewHomeVC: J_BaseVC {

    fileprivate var collectionView : UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionView()
    }
    

    func initCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
//        layout.itemSize = CGSize(width: (J_UI.Screen.Width - 21.5)/4, height: 60)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 0.5
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        // 注册cell
        collectionView?.register(J_NewHomeCollectionViewCell.self, forCellWithReuseIdentifier: "item")
        // 注册headerView
        collectionView?.register(J_NewHomeHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier")
        // 注册footView
        collectionView?.register(J_NewHomeFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footIdentifier")
        
    }


}

extension EMNewHomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:J_NewHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! J_NewHomeCollectionViewCell
        cell.backgroundColor = armColor()
        return cell
    }
    
    //设定header和footer的方法，根据kind不同进行不同的判断即可
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView : J_NewHomeHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier", for: indexPath) as! J_NewHomeHeaderReusableView
            headerView.backgroundColor = UIColor.red
            return headerView
        }else{
            let footView : J_NewHomeFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footIdentifier", for: indexPath) as! J_NewHomeFooterReusableView
            footView.backgroundColor = UIColor.purple
            return footView
        }
    }
    
    // item 大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (J_UI.Screen.Width - 21.5)/4, height: 60)
    }
    
    // item 上下间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  10
    }
    // item  左右间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    //    //header高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: J_UI.Screen.Width, height: 80)
    }
    //footer高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: J_UI.Screen.Width, height: 80)
    }
    
    // 周围边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    
    
    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

