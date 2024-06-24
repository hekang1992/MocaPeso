//
//  LaunchViewController.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import Alamofire
import AppsFlyerLib
import AdSupport
import HandyJSON
import RxSwift

class LaunchViewController: FCBaseViewController {
    
    var isGit: Bool = false
    
    var apiArray: [String] = []
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .gray
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 3, height: 0)
        return scrollView
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.isUserInteractionEnabled = true
        icon1.backgroundColor = .red
        return icon1
    }()
    
    lazy var icon2: UIImageView = {
        let icon2 = UIImageView()
        icon2.isUserInteractionEnabled = true
        icon2.backgroundColor = .black
        return icon2
    }()
    
    lazy var icon3: UIImageView = {
        let icon3 = UIImageView()
        icon3.isUserInteractionEnabled = true
        icon3.backgroundColor = .purple
        return icon3
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        JudgNetWork()
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.image = UIImage(named: "launch")
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        UserDefaults.standard.setValue("", forKey: "isshow")
        UserDefaults.standard.synchronize()
        //        setupScrollView()
    }
    
    func JudgNetWork() {
        NetworkManager.shared.observeNetworkStatus { [weak self] status in
            switch status {
            case .none:
                print("无网络连接")
                break
            case .wifi:
                print("网络>>>>>>>WIFI")
                self?.requsetUrl()
                break
            case .cellular:
                print("网络>>>>>>>4G/5G")
                self?.requsetUrl()
                break
            }
        }
    }
}

extension LaunchViewController {
    
    func requsetUrl() {
        let dict = ["accent":"1", "parenthetically": "1"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: gileFilee, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                self?.upApiInfo()
            }else {
                self?.requestGitStr()
            }
        } errorBlock: { [weak self] error in
            self?.requestGitStr()
        }
    }
    
    func requestGitStr() {
        DispatchQueue.global(qos: .default).async {
            let originalURLString = BASE_GIT_URL
            guard let data = originalURLString.data(using: .utf8) else { return }
            let base64String = data.base64EncodedString()
            guard let decodedData = Data(base64Encoded: base64String),
                  let decodedURLString = String(data: decodedData, encoding: .utf8),
                  let url = URL(string: decodedURLString) else {
                return
            }
            do {
                let base64 = try String(contentsOf: url, encoding: .utf8)
                let decodedString = base64.replacingOccurrences(of: "\n", with: "")
                guard let finalDecodedData = Data(base64Encoded: decodedString),
                      let stringV = String(data: finalDecodedData, encoding: .utf8) else {
                    return
                }
                let stringArray = stringV.components(separatedBy: ",")
                DispatchQueue.main.async {
                    self.apiArray = stringArray
                    self.arrayApi(gileFilee, index: 0)
                }
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
    
    func arrayApi(_ apiUrl: String, index: Int) {
        if isGit == false {
            guard index < apiArray.count else { return }
            UserDefaults.standard.set(apiArray[index], forKey: APIBAERURL)
            UserDefaults.standard.synchronize()
            let dict = ["accent":"1", "parenthetically": "1"]
            FCRequset.shared.requestAPI(params: dict, pageUrl: gileFilee, method: .get) { [weak self] baseModel in
                let conceive = baseModel.conceive
                if conceive == 0 || conceive == 00 {
                    self?.isGit = true
                    self?.upApiInfo()
                }else {
                    self?.isGit = false
                    self?.arrayApi(gileFilee, index: index + 1)
                }
            } errorBlock: { [weak self] error in
                self?.isGit = false
                self?.arrayApi(gileFilee, index: index + 1)
            }
        }
    }
    
    func upApiInfo() {
        getApplePush()
        getAppleGoogle()
        getAppleLocation()
        getRootVcPush()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(icon1)
        scrollView.addSubview(icon2)
        scrollView.addSubview(icon3)
        scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        icon1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        icon2.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        icon3.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    }
    
}
