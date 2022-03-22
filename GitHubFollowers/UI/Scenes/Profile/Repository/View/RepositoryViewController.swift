//
//  RepositoryViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import UIKit
import WebKit
import SnapKit

class RepositoryViewController: UIViewController, WKNavigationDelegate {
    var viewModel: RepositoryViewModelProtocol?
    var webView: WKWebView!
    
    let loadingView: GFLoadingView = {
        let view = GFLoadingView()
        view.backgroundColor = colors.background()
        return view
    }()
    
    override func loadView() {
        configure()
        setup()
        load()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.addSubview(loadingView)
    }
    
    func setup() {
        loadingView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
    }
    
    func load() {
        if let url = viewModel?.repositoryUrl {
            webView.load(URLRequest(url: url))
        }
    }
}

extension RepositoryViewController: UIWebViewDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.isHidden = true
    }
}
