//
//  DelAccountViewController.swift
//  FutureCash
//
//  Created by apple on 2024/4/25.
//

import UIKit
import MBProgressHUD

class DelAccountViewController: FCBaseViewController {
    
    lazy var delView: FCDelAccountView = {
        let delView = FCDelAccountView()
        return delView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        addDelAccountView()
        delView.block = { [weak self] isBool in
            if isBool == true && IS_LOGIN {
                self?.deleAccountApi()
            }
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

extension DelAccountViewController {
    
    func addDelAccountView() {
        view.insertSubview(delView, belowSubview: navView)
        delView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func deleAccountApi() {
        let dict: [String: Any] = [:]
        FCRequset.shared.requestAPI(params: dict, pageUrl: theAfter, method: .get) { [weak self] baseModel in
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
