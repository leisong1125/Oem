//
//  J_HomeVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/20.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import FSCalendar
import EventKit

class J_HomeVC: J_BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightLayout: NSLayoutConstraint!
    
    fileprivate var listM : [J_PlanModel] = []
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.chinese)
    
    fileprivate var minimumDate : Date?
    fileprivate var maximumDate : Date?
    fileprivate var events     : [EKEvent] = []
    fileprivate var lunarFormatter     : J_LunarFormatter?
    fileprivate var cache : NSCache<AnyObject, AnyObject>?
    
    lazy var emptyLab: UILabel! = {
        let lab = UILabel(frame: CGRect(x: 0, y: 30, width: J_UI.Screen.Width, height: 30))
        lab.textAlignment = .center
        lab.text = "还没有行程，赶快安排一下吧！"
        return lab
    }()
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.cache?.removeAllObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initChinese()
        initCalendar()
        
        self.tableView.addSubview(emptyLab)
        emptyLab.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleData(date: calendar.selectedDate ?? Date())
    }
    
    func initCalendar() {
        self.calendar.select(Date())
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
        self.calendar.appearance.headerDateFormat = "yyyy年MM月"
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        navigationItem.title = "行程"
    }
    
    func initChinese() {
        
        self.lunarFormatter = J_LunarFormatter()
        self.minimumDate = self.dateFormatter.date(from: "1970年01月01")
        self.maximumDate = self.dateFormatter.date(from: "2100年12月31")
        let store = EKEventStore()
        
        store.requestAccess(to: EKEntityType.event) { [weak self](granted, error) in
            if granted == true {
                let startDate = (self?.minimumDate)!
                let endDate = (self?.maximumDate)!
                let fetchCalendarEvents = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                let eventList = store.events(matching: fetchCalendarEvents)
                let events = (eventList as NSArray).filtered(using: NSPredicate(block: { (evaluatedObject, bindings) -> Bool in
                    return (evaluatedObject as? EKEvent)!.calendar.isSubscribed
                }))
                
                DispatchQueue.main.async {
                    self?.events = events as? [EKEvent] ?? []
                    self?.calendar.reloadData()
                }
            }
        }
    }
    
    
    func eventsFor(date: Date) -> [EKEvent] {
        let tempEvents = self.cache?.object(forKey: date as AnyObject)
        if  tempEvents == nil {
            return []
        }
        
        let filteredEvents = (self.events as NSArray).filtered(using: NSPredicate(block: { (evaluatedObject, bindings) -> Bool in
            if #available(iOS 9.0, *) {
                return (evaluatedObject as? EKEvent)?.occurrenceDate == date
            } else {
                return false
            }
        }))
        
        if filteredEvents.count > 0{
            self.cache?.setObject(filteredEvents as AnyObject, forKey: date as AnyObject)
        }else{
            self.cache?.setObject([] as AnyObject, forKey: date as AnyObject)
        }
        return filteredEvents as! [EKEvent]
    }
}

extension J_HomeVC: FSCalendarDelegate, FSCalendarDataSource, UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightLayout.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        handleData(date: date)
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        return eventsFor(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let event = eventsFor(date: date).first
        if event != nil {
            return event!.title
        }
        return self.lunarFormatter?.stringFrom(date: date)
    }
}

extension J_HomeVC{
    
    func initModel()-> J_PlanModel {
        let model = J_PlanModel()
        model.content = "来创建一个计划，规划一下行程吧！！！"
        model.title  = "计划标题"
        let image = UIImage.initWith(color: J_UI.Color.primary)
        model.topImage = image.jpegData(compressionQuality: 1.0)
        model.startTime = Date()
        model.endTime = Date()
        model.isPush = true
        model.labelDate = Date().toString(format: .barYMd)
        return model
    }
    
    func handleData(date: Date) {
        J_PlanReam.manger.getPlan(label: date.toString(format: .barYMd)) {[weak self] (list) in
            
            self?.listM = list
            if date.toString(format: .barYMd) == Date().toString(format: .barYMd){
                self?.listM.insert((self?.initModel())!, at: 0)
            }
            self?.tableView.reloadData()
        }
    }
    
}



extension J_HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyLab.isHidden = listM.count > 0
        return listM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeCell, for: indexPath)!
        cell.updateValue(model: listM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "删除") {[weak self] (action, indexPath) in
            debugPrint("删除")
            let model = self?.listM[indexPath.row]
            if !(model?.content == "来创建一个计划，规划一下行程吧！！！" && model?.title  == "计划标题") {
                J_PlanReam.manger.delePlan(model: model)
                self?.listM.remove(at: indexPath.row)
            }else{
                J_HUD.show(text: "默认不能删除")
            }
            tableView.reloadData()
        }
        
        return [delete]
    }
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "删除") {[weak self] (action, view, completionHandler) in
            let model = self?.listM[indexPath.row]
            if !(model?.content == "来创建一个计划，规划一下行程吧！！！" && model?.title  == "计划标题") {
                J_PlanReam.manger.delePlan(model: model)
                self?.listM.remove(at: indexPath.row)
            }else{
                J_HUD.show(text: "默认不能删除")
            }
            tableView.reloadData()
            tableView.setEditing(false, animated: true)
            completionHandler(true)
        }
        let actions = UISwipeActionsConfiguration(actions: [delete])
        actions.performsFirstActionWithFullSwipe = false
        
        return actions
    }
}

class J_HomeTableCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var subTitleLab: UILabel!
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    
    
    func updateValue(model: J_PlanModel)  {
        
        if model.topImage != nil {
            imageV.image = UIImage(data: model.topImage!)
        }
        titleLab.text = model.title
        subTitleLab.text = model.content
        dateLab.text = model.startTime?.toString(format: .timeShort)
    }
    
}
