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
    private var transparentBgView: UIView!
    
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
        webView.frame = webViewFrame()
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
        
        transparentBgView = UIView(frame: self.view.bounds)
        transparentBgView.backgroundColor = .black
        transparentBgView.alpha = 0.8
        view.addSubview(transparentBgView)

        webView = WKWebView(frame: webViewFrame())
        webView.navigationDelegate = self
        view.addSubview(webView)
        setupActivityIndicator()

        let closeButton = UIButton(frame: CGRect(x: 0.8 * self.view.bounds.width, y: 0, width: 100, height: 100))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(URLBrowsingScreen.didPressedDismissButton), for: .touchUpInside)
        view.addSubview(closeButton)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func webViewFrame() -> CGRect {
        let oXOffset: CGFloat = self.view.bounds.width * 0.1
        let oYOffset: CGFloat = self.view.bounds.height * 0.1
        return CGRect(x: oXOffset, y: oYOffset, width: self.view.bounds.width - 2 * oXOffset, height: self.view.bounds.height - 2 * oYOffset)
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
    }

    // MARK: Gesture recognizer
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
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
