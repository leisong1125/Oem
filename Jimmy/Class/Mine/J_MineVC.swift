//
//  J_MineVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class J_MineVC: J_BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    var titleAry : [[String]] = [["日记", "便签"], ["意见反馈", "关于我们"]]
    var imagesAry : [[UIImage]] = [[R.image.mine_riji()!, R.image.mine_bianqian()!],[R.image.mine_fankui()!, R.image.mine_bout()!]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

}

extension J_MineVC : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleAry.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleAry[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_MineTableCell, for: indexPath)!
        cell.imageV.image = imagesAry[indexPath.section][indexPath.row]
        cell.titleLab.text = titleAry[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let listVC = R.storyboard.main.j_DiaryListVC()!
            navigationController?.pushViewController(listVC, animated: true)
            break
        case (0, 1):
            let listVC = R.storyboard.main.j_NoteListVC()!
            navigationController?.pushViewController(listVC, animated: true)
            break
        case (1, 0):
            let listVC = R.storyboard.main.j_FeedbackVC()!
            navigationController?.pushViewController(listVC, animated: true)
            break
        case (1, 1):
            let listVC = R.storyboard.main.j_AboutUsVC()!
            navigationController?.pushViewController(listVC, animated: true)
            break
        default:
            break
        }
        
    }
    
}



class J_MineTableCell: UITableViewCell {
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    
}
