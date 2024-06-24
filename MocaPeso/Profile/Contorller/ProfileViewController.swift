//
//  ProfileViewController.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import TYAlertController
import MBProgressHUD
import StoreKit

class ProfileViewController: FCBaseViewController {
    
    lazy var setView: FCSetView = {
        let setView = FCSetView()
        return setView
    }()
    
    lazy var outView: FCLogOutView = {
        let outView = FCLogOutView(frame: self.view.bounds)
        return outView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.titleLable.text = "Setting"
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        addSetView()
        setView.block1 = { [weak self] in
            self?.toGrade()
        }
        setView.block2 = { [weak self] in
            if IS_LOGIN {
                self?.logOut()
            }else {
                self?.addLoginView()
            }
            
        }
        setView.block3 = { [weak self] in
            self?.delAccount()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ProfileViewController {
    
    func toGrade() {
        let loadView = ViewHud.createLoadView()
        if let keyWindow = UIApplication.shared.windows.first {
            keyWindow.addSubview(loadView)
        }
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene  {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
        ViewHud.hideLoadView()
    }
    
    func addSetView() {
        view.insertSubview(setView, belowSubview: navView)
        setView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func logOut() {
        let alertVC = TYAlertController(alert: outView, preferredStyle: .alert)
        self.present(alertVC!, animated: true)
        outView.block1 = { [weak self] in
            self?.dismiss(animated: true)
        }
        outView.block = { [weak self] in
            self?.logOutSys()
        }
    }
    
    func logOutSys() {
        self.dismiss(animated: true) {
            self.requestLogOutApi()
        }
    }
    
    func delAccount() {
        if IS_LOGIN {
            let delVc = DelAccountViewController()
            self.navigationController?.pushViewController(delVc, animated: true)
        }else {
            self.addLoginView()
        }
    }
    
    func requestLogOutApi() {
        let dict: [String: Any] = [:]
        FCRequset.shared.requestAPI(params: dict, pageUrl: childiveMorley, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting
            if conceive == 0 || conceive == 00 {
                LoginFactory.removeLoginInfo()
                self?.delayTime(0.25) {
                    FCNotificationCenter.post(name: NSNotification.Name(FCAPPLE_ROOT_VC), object: nil)
                }
            }
            MBProgressHUD.show(text: wanting ?? "")
        } errorBlock: { error in
            
        }
    }
    
}
