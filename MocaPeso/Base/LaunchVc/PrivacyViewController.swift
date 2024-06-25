//
//  PrivacyViewController.swift
//  MocaPeso
//
//  Created by apple on 2024/6/24.
//

import UIKit
import WebKit
import TYAlertController

class PrivacyViewController: FCBaseViewController {
    
    var block: (() -> Void)?
    
    lazy var youkeView: YouKeView = {
        let youkeView = YouKeView(frame: self.view.bounds)
        return youkeView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "pribgimageff")
        return bgImageView
    }()
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView1 = UIImageView()
        bgImageView1.isUserInteractionEnabled = true
        bgImageView1.image = UIImage(named: "Groupfgdvads")
        return bgImageView1
    }()
    
    lazy var bgImageView2: UIImageView = {
        let bgImageView2 = UIImageView()
        bgImageView2.isUserInteractionEnabled = true
        bgImageView2.image = UIImage(named: "silefivnut5")
        return bgImageView2
    }()
    
    lazy var webView1: WKWebView = {
        let webView1 = WKWebView()
        webView1.layer.cornerRadius = 20.px()
        return webView1
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
        return btn2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let height = UIViewController.getTopBarHeights(for: self)
        // Do any additional setup after loading the view.
        self.navView.isHidden = true
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.insertSubview(bgImageView, belowSubview: navView)
        bgImageView.addSubview(scrollView)
        scrollView.addSubview(bgImageView1)
        bgImageView1.addSubview(webView1)
        bgImageView.addSubview(bgImageView2)
        bgImageView2.addSubview(btn1)
        bgImageView2.addSubview(btn2)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(23.px())
            make.height.equalTo(584.px())
            make.top.equalToSuperview().offset(height.navigationBarHeight.px())
        }
        webView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(5.px())
            make.bottom.equalToSuperview().offset(-5.px())
            make.top.equalToSuperview().offset(53.px())
        }
        bgImageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(134.px())
        }
        btn1.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(150.px())
        }
        btn2.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(btn1.snp.right)
        }
        self.bgImageView2.setNeedsLayout()
        self.view.layoutIfNeeded()
        let maxY = CGRectGetMaxY(bgImageView2.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
        let url = URL(string: "https://tawid-lending.com/alfredWhatsername")!
        webView1.load(URLRequest(url: url))
    }
    
    @objc func btnClick() {
        exit(0)
    }
    
    @objc func btnClick1() {
        let alertVC = TYAlertController(alert: youkeView, preferredStyle: .actionSheet)
        youkeView.label1.text = "Please choose your login method"
        self.present(alertVC!, animated: true)
        youkeView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        youkeView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.block?()
                UserDefaults.standard.set("1", forKey: IS_TWO)
                UserDefaults.standard.synchronize()
            })
        }
        youkeView.block3 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.block?()
            })
        }
    }
    
}
