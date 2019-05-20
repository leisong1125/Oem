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
    
//    fileprivate var lunarDay : Int = 0
//    fileprivate var lunarChars : [String] = []
    
    fileprivate var minimumDate : Date?
    fileprivate var maximumDate : Date?
    fileprivate var events     : [EKEvent] = []
    fileprivate var lunarFormatter     : J_LunarFormatter?
    
    
    fileprivate var cache : NSCache<AnyObject, AnyObject>?
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.cache?.removeAllObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initChinese()
        initCalendar()
        
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
            return (evaluatedObject as? EKEvent)?.occurrenceDate == date
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

extension J_HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeCell, for: indexPath)!
        
        cell.textLabel?.text = "测试数据"
        
        return cell
    }    
}
