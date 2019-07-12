//
//  J_TestVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/6/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import WebKit

let Width : CGFloat = J_UI.Screen.Width
let Height : CGFloat = J_UI.Screen.Height - 50


class J_TestVC: J_BaseVC, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var contentView: UIView!
    
    lazy var scrollView : UIScrollView! = {
        let scr = UIScrollView(frame: CGRect.zero)
        scr.backgroundColor = UIColor.red
        scr.delegate = self
        scr.contentSize = CGSize(width: Width, height: Height*2)
        scr.contentOffset = CGPoint.zero
        scr.isScrollEnabled = false
        return scr
    }()
    
    lazy var tableView : UITableView! = {
        let frame = CGRect(x: 0, y: 0, width: Width, height: Height)
        let tab = UITableView(frame: frame)
        tab.delegate = self
        tab.dataSource = self
        return tab
    }()
    lazy var webView : CustomWebView! = {
        let frame = CGRect(x: 0, y: Height, width: Width, height: Height)
        let view = CustomWebView(frame: frame)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewUI()
        
        
        
//        let baseArray : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//        let len = baseArray.count
//        let n : Int = 2 //假设每行显示2个
//        let lineNum : Int = len % n == 0 ? len / n : Int(floor(Double((len / n) + 1)))
//        var res : [[Int]] = [];
//
//        for i in 0..<lineNum {
//            // slice() 方法返回一个从开始到结束（不包括结束）选择的数组的一部分浅拷贝到一个新数组对象。且原始数组不会被修改。
//            let start = i*n
//            var end = i*n+n
//            if end > len {
//                end = len
//            }
//            let temp = Array(baseArray[start..<end]) //.slice(i*n, i*n+n);
//            res.append(temp)
//        }
//        print(res)
        
        
    }
    
    func initViewUI() {
        
        setScrollViewContentMoving(scrollView: scrollView)
        setScrollViewContentMoving(scrollView: tableView)
        self.contentView.addSubview(scrollView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(webView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        tableView.mj_footer = J_RefreshTool.footer(closure: {
            
            self.tableView.mj_footer.endRefreshing()
            self.openWebView()
        })
        
        webView.webView?.scrollView.mj_header = J_RefreshTool.header(closure: {
            self.webView.webView?.scrollView.mj_header.endRefreshing()
            
            self.openTableView()
        })
        
        
    }
    
    func openWebView() {
        self.scrollView.isScrollEnabled = true
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: Height)
        }) { (result) in
            self.scrollView.isScrollEnabled = false
        }
    }
    
    func openTableView() {
        self.scrollView.isScrollEnabled = true
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.contentOffset = CGPoint.zero
        }) { (result) in
            self.scrollView.isScrollEnabled = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "测试数据\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CustomWebView: UIView {

    var webView : WKWebView?
    var activityIndicator : UIActivityIndicatorView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        
        webView?.load(URLRequest(url: URL(string: "https://www.baidu.com/")!))
        
    }
    
    
    func initView() {
        let topView = UIView(frame: CGRect.zero)
//        topView.backgroundColor = UIColor.purple
        self.addSubview(topView)
        
        topView.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(64)
        })
        
        let configure = WKWebViewConfiguration()
        configure.allowsInlineMediaPlayback = true
        
        let userController = WKUserContentController()
        configure.userContentController = userController
        
        webView = WKWebView.init(frame: CGRect.zero, configuration: configure)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        webView?.translatesAutoresizingMaskIntoConstraints = false
//        webView?.scrollView.bounces = false
        webView?.scrollView.isUserInteractionEnabled = true
        webView?.scrollView.delegate = self
        self.addSubview(webView!)
        
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        self.addSubview(activityIndicator!)
        activityIndicator?.color = UIColor.gray
        
        activityIndicator?.snp.makeConstraints({ (make) in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(40)
        })
        webView?.snp.makeConstraints({ (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        
    }
    
    
    
    
    deinit {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CustomWebView: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate {
    
    /// 禁止缩放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    /// 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        activityIndicator?.startAnimating()
        
    }
    
    /// 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator?.stopAnimating()
    }
    
    // 处理js交互
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == jsModelName {
//            guard let params = message.body as? [String:Any] else { return }
//            EMWebManager.manger.doWith(params: params)
//        }
    }
    
    /// 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

extension CustomWebView {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = change?[NSKeyValueChangeKey.newKey] as? Float ?? 0.0
            print("progress --- \(progress)")
            if progress >= 1.0 {
                activityIndicator?.stopAnimating()
                
            }else if progress > 0 {
                
            }
        }
    }
}
