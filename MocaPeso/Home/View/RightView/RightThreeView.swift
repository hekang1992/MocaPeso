//
//  RightThreeView.swift
//  FutureCash
//
//  Created by apple on 2024/5/14.
//

import UIKit
import WebKit
import MBProgressHUD

class RightThreeView: UIView {
    
    var kefuURl: String?
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let scriptNames = ["somethingSolid", "sisters"]
        for scriptName in scriptNames {
            userContentController.add(self, name: scriptName)
        }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5.px(), left: 5.px(), bottom: 5.px(), right: 10.px()))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RightThreeView: WKNavigationDelegate, WKScriptMessageHandler {
    
    func loadKeFu() {
        let kefuUrl = GetBaseApi.setBaseApiUrl() + "/overcomeFirst" + "?" + LoginFactory.getLoginParas()
        let stringWithoutSpaces = kefuUrl.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: stringWithoutSpaces) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [String] else {
            print("Invalid message body")
            return
        }
        let methodName = message.name
        let methodArgs = body
        let methodMapping: [String: () -> Void] = [
            "somethingSolid": { self.callPhoneMethod(methodArgs) },
            "sisters": { self.jumpToEmail(methodArgs) }
        ]
        if let method = methodMapping[methodName] {
            method()
        } else {
            print("Unknown method: \(methodName)")
        }
    }
    
    func callPhoneMethod(_ arguments: [String]) {
        if let phone = arguments.first {
            let phoneStr = "telprompt://\(phone)"
            if let phoneURL = URL(string: phoneStr), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func jumpToEmail(_ arguments: [String]) {
        let email = arguments.first ?? ""
        let subject = arguments[1]
        let orderID = arguments.last ?? ""
        let mobileStr = UserDefaults.standard.object(forKey: PHONE_LOGIN)
        var strBody = "Tawid Loan Account: \(mobileStr ?? "")"
        if !orderID.isEmpty {
            strBody += ", orderId: \(orderID)"
        }
        let mailtoString = "mailto:\(email)?subject=\(subject)&body=\(strBody)"
        if let encodedUrlString = mailtoString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let mailtoUrl = URL(string: encodedUrlString) {
            if UIApplication.shared.canOpenURL(mailtoUrl) {
                UIApplication.shared.open(mailtoUrl, options: [:], completionHandler: nil)
            } else {
                print("Can't open email client")
            }
        } else {
            print("Invalid mailto URL")
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        ViewHud.hideLoadView()
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let urlStr = url.absoluteString
        if urlStr.hasPrefix("mailto:") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if urlStr.hasPrefix("whatsapp:") {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    MBProgressHUD.show(text: "WhatsApp is not installed. Please install it.")
                }
            }
        }
        if urlStr.hasPrefix("mailto:") || urlStr.hasPrefix("whatsapp:") {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let loadView = ViewHud.createLoadView()
        if let keyWindow = UIApplication.shared.windows.first {
            keyWindow.addSubview(loadView)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            ViewHud.hideLoadView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ViewHud.hideLoadView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        ViewHud.hideLoadView()
    }
    
}
