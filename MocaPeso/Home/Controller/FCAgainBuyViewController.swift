//
//  FCAgainBuyViewController.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/22.
//

import UIKit
import MJRefresh
import HandyJSON

class FCAgainBuyViewController: FCBaseViewController {
    
    lazy var buyView: FCAgainBuyView = {
        let buyView = FCAgainBuyView()
        return buyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.titleLable.text = "Product Selection List"
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addBuyView()
        self.buyView.tableView.mj_header = FCPullHeader(refreshingTarget: self, refreshingAction: #selector(loadHomeData))
        buyView.block4 = { [weak self] model in
            self?.applyClick(model.particularly ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAgainBuyData()
    }
    
}

extension FCAgainBuyViewController {
    
    func addBuyView() {
        view.insertSubview(buyView, belowSubview: navView)
        buyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func loadHomeData() {
        getAgainBuyData()
    }
    
    func getAgainBuyData() {
        let dict = ["accent":"1", "parenthetically":"2"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: cheerfulMirror, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                let modelArray = model?.palace
                self?.buyView.productArray = modelArray
                self?.buyView.tableView.reloadData()
                self?.buyView.tableView.mj_header?.endRefreshing()
            }
        } errorBlock: { [weak self] error in
            self?.buyView.tableView.mj_header?.endRefreshing()
        }
        
    }
    
}
