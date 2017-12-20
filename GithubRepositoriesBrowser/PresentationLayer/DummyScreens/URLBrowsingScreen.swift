//
//  URLBrowsingScreen.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit
import WebKit

class URLBrowsingScreen: UIViewController {
    private var webView: WKWebView!
    private var url: URL?
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Initializers
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        loadURL()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = view.center
    }
    
    // MARK: - Methods
    private func loadURL() {
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Setup
    private func setupAppearance() {
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        setupActivityIndicator()
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(URLBrowsingScreen.didPressedDismissButton))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Actions
    @objc private func didPressedDismissButton() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate
extension URLBrowsingScreen: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
