//
//  FCBankInfoViewController.swift
//  FutureCash
//
//  Created by apple on 2024/5/8.
//

import UIKit
import HandyJSON
import MBProgressHUD

class FCBankInfoViewController: FCBaseViewController {
    
    var particularly: String?
    
    var bankArray: [ExceptModel]?
    
    lazy var walletVc: FCWalletViewController = {
        let walletVc = FCWalletViewController()
        return walletVc
    }()
    
    lazy var bankVc: FCBankViewController = {
        let bankVc = FCBankViewController()
        return bankVc
    }()
    
    lazy var bankWalletView: FCBankWalletView = {
        let bankWalletView = FCBankWalletView()
        bankWalletView.iconImageView2.image = UIImage(named: "bankImagef")
        return bankWalletView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addBankView()
        bankWalletView.block = { [weak self] btn in
            self?.walletOrBankClick(btn)
        }
        getBankInfo()
    }
    
}

extension FCBankInfoViewController {
    
    func addBankView() {
        view.insertSubview(bankWalletView, belowSubview: navView)
        bankWalletView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func walletOrBankClick(_ btn: UIButton) {
        let images: [UIButton: (UIImage, UIImage)] = [
            self.bankWalletView.walletBtn: (UIImage(named: "walletsel")!, UIImage(named: "walletnosel")!),
            self.bankWalletView.bankBtn: (UIImage(named: "banksel")!, UIImage(named: "banknosel")!)
        ]
        let selectedIndex = btn == self.bankWalletView.walletBtn ? 0 : 1
        moveIndex(selectedIndex)
        for (button, buttonImages) in images {
            let (selectedImage, deselectedImage) = buttonImages
            button.setBackgroundImage(button == btn ? selectedImage : deselectedImage, for: .normal)
        }
    }
    
    func getBankInfo() {
        let dict = ["relations": particularly ?? ""]
        FCRequset.shared.requestAPI(params: dict, pageUrl: andChair, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelArray = model.except
                    if let modelArray = modelArray {
                        self?.walletVc.particularly = self?.particularly ?? ""
                        self?.bankVc.particularly = self?.particularly ?? ""
                        let walletArray: [ExceptModel] = (modelArray.first?.except!)!
                        let bankArray: [ExceptModel] = (modelArray.last?.except!)!
                        self?.bankArray = bankArray
                        self?.addChildVc(walletArray)
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func addChildVc(_ array: [ExceptModel]) {
        self.walletVc.walletView.modelArray = array
        self.walletVc.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 187.px() - 95.px())
        self.bankWalletView.scrollView.addSubview(self.walletVc.view)
        self.addChild(self.walletVc)
        self.walletVc.walletView.tableView.reloadData()
    }
    
    func moveIndex(_ index: Int) {
        self.bankVc.walletView.modelArray = bankArray
        self.bankVc.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 187.px() - 95.px())
        self.bankWalletView.scrollView.addSubview(self.bankVc.view)
        addChild(self.bankVc)
        self.bankWalletView.scrollView.setContentOffset(CGPoint(x: Int(SCREEN_WIDTH) * index, y: 0), animated: true)
        self.bankVc.walletView.tableView.reloadData()
    }
    
}
