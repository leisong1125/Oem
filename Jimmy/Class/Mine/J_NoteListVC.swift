//
//  J_NoteList.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class J_NoteListVC: J_BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var listM : [J_NoteModel] = []
    
    
    lazy var emptyLab: UILabel! = {
        let lab = UILabel(frame: CGRect(x: 0, y: 30, width: J_UI.Screen.Width, height: 30))
        lab.textAlignment = .center
        lab.text = "还没有便签，赶快创建一个吧！"
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.addSubview(emptyLab)
        emptyLab.isHidden = true
        
        navigationItem.title = "便签"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "创建", style: .plain, target: self, action: #selector(creatAction))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        J_NoteReam.manger.getNote(succ: { [weak self](list) in
            self?.listM = list
            self?.tableView.reloadData()
        })
    }
    
    
    @objc func creatAction() {
        let vc = R.storyboard.main.j_NoteVC()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension J_NoteListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyLab.isHidden = listM.count > 0
        return listM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.j_NoteListTableCell, for: indexPath)!
        
        let model = listM[indexPath.row];
        cell.textLabel?.text = model.dayLabel + ":" + model.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = R.storyboard.main.j_NoteVC()!
        vc.noteM = listM[indexPath.row];
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "删除") {[weak self] (action, indexPath) in
            debugPrint("删除")
            J_NoteReam.manger.deleNote(model: self?.listM[indexPath.row])
            self?.listM.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        return [delete]
    }
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "删除") {[weak self] (action, view, completionHandler) in
            J_NoteReam.manger.deleNote(model: self?.listM[indexPath.row])
            self?.listM.remove(at: indexPath.row)
            tableView.reloadData()
            tableView.setEditing(false, animated: true)
            completionHandler(true)
        }
        let actions = UISwipeActionsConfiguration(actions: [delete])
        actions.performsFirstActionWithFullSwipe = false
        
        return actions
    }
    
}
