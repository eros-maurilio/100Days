//
//  ViewController.swift
//  WebKitProject
//
//  Created by Eros Maurilio on 25/08/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var selectedUrl: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let foward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton,spacer, back, spacer, foward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https:/" + selectedUrl!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true


    }
    
    //    @objc func openTapped() {
    //        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    //        for website in websites {
    //        ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    //        }
    //
    //        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    //        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    //        present(ac, animated: true)
    //    }
    
    //    func openPage(action: UIAlertAction) {
    //        guard let actionTitle = action.title else { return }
    //        guard let url = URL(string: "https://" + actionTitle) else { return }
    //        webView.load(URLRequest(url: url))
    //    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            if host.contains(selectedUrl!) {
                decisionHandler(.allow)
                return
            }
        }
        
        let alert = UIAlertController(title: "Not Allowed", message: "Browsing outside of this website is not allowed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        decisionHandler(.cancel)
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

