//
//  J_WKWebViewVC.swift
//  Jimmy
//
//  Created by zhaofan on 2019/5/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit

class J_WKWebViewVC: J_BaseVC {

    fileprivate var om : J_OModel?
    
    fileprivate var webView : WKWebView?
    fileprivate var progressView:UIProgressView?
    
    @IBOutlet weak var topHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var wkView: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var outBtn: UIButton!
    
    class func getWkWebView(om: J_OModel) -> J_WKWebViewVC {
        let vc = R.storyboard.main.j_WKWebViewVC()!
        vc.om = om
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleRx()
        initWebViewUI()
        initData()
    }
    
    func initData() {
        guard let newUrl = URL(string: om?.plan_open_url ?? "") else { return }
        debugPrint(newUrl)
        let req = URLRequest(url: newUrl)
        webView?.load(req)
    }
    
}

extension J_WKWebViewVC: WKUIDelegate, WKNavigationDelegate {
    
    func initWebViewUI() {
        topHeightLayout.constant = J_UI.Screen.StatusbarH
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let configure = WKWebViewConfiguration()
        webView = WKWebView.init(frame: CGRect.zero, configuration: configure)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
                webView?.allowsBackForwardNavigationGestures = true//web侧滑手势
        webView?.translatesAutoresizingMaskIntoConstraints = false
        wkView.addSubview(webView!)
        
        webView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        //progressview
        progressView = UIProgressView()
        progressView!.frame = CGRect(x:0, y: 0, width:view.bounds.width, height:1);
        progressView!.trackTintColor = UIColor.white
        progressView!.progressTintColor = J_UI.Color.primary
        progressView?.isHidden = true
        wkView.addSubview(progressView!)
        
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    /// 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView?.isHidden = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = change?[NSKeyValueChangeKey.newKey] as? Float ?? 0.0
            if progress >= 1.0 {
                progressView?.setProgress(progress, animated: true)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: { [weak self] in
                    self?.progressView?.alpha = 0.0
                    }, completion: { [weak self](_) in
                        self?.progressView?.setProgress(0.0, animated: false)
                })
            }else {
                progressView?.alpha = 1.0
                progressView?.setProgress(progress, animated: true)
            }
        }
    }
    
    
}


extension J_WKWebViewVC {
    
    func handleRx() {
        homeBtn.rx.tap .subscribe(onNext: {[weak self] (_) in
            self?.to_Home()
        }).disposed(by: disposeBag)
        
        backBtn.rx.tap .subscribe(onNext: {[weak self] (_) in
            self?.to_back()
        }).disposed(by: disposeBag)
        
        goBtn.rx.tap .subscribe(onNext: {[weak self] (_) in
            self?.to_go()
        }).disposed(by: disposeBag)
        
        refreshBtn.rx.tap .subscribe(onNext: {[weak self] (_) in
            self?.to_refresh()
        }).disposed(by: disposeBag)
        
        outBtn.rx.tap .subscribe(onNext: {[weak self] (_) in
            self?.to_out()
        }).disposed(by: disposeBag)
    }
    
    func to_Home() {
        initData()
    }
    
    func to_back() {
        if webView?.canGoBack == true {
            webView?.goBack()
        }
    }
    
    func to_go() {
        if webView?.canGoForward == true {
            webView?.goForward()
        }
    }
    
    func to_refresh() {
        webView?.reload()
    }
    
    func to_out() {
        J_Alert.show(title: nil, content: "离开应用", trueTitle: "确定", cancelTitle: "取消") {
            exit(0)
        }
    }
}
