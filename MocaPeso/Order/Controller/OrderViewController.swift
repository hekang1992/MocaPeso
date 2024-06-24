//
//  OrderViewController.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import MJRefresh
import HandyJSON
import MBProgressHUD

class OrderViewController: FCBaseViewController {
    
    var eight: String?
    
    lazy var orderView: FCOrderView = {
        let orderView = FCOrderView()
        if eight == "5" {
            orderView.iconImageView2.image = UIImage(named: "Slicefull")
        }else if eight == "6" {
            orderView.iconImageView2.image = UIImage(named: "orderiiid")
        }else if eight == "7" {
            orderView.iconImageView2.image = UIImage(named: "Sliceprocess")
        }else if eight == "8" {
            orderView.iconImageView2.image = UIImage(named: "Slicefailuer")
        }else if eight == "9" {
            orderView.iconImageView2.image = UIImage(named: "twodadoin")
        }
        return orderView
    }()
    
    lazy var nodataView: FCNodataView = {
        let nodataView = FCNodataView()
        return nodataView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addOrderView()
        orderView.block = { [weak self] model, type in
            self?.pushDetailVcWithModel(model, type)
        }
        self.orderView.tableView.mj_header = FCPullHeader(refreshingTarget: self, refreshingAction: #selector(loadOrderData))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadOrderData()
    }
    
}

extension OrderViewController {
    
    func addOrderView() {
        view.insertSubview(orderView, belowSubview: navView)
        orderView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func pushDetailVcWithModel(_ model: PlaceModel, _ type: String) {
        let obvious = model.obvious ?? ""//cellClick 跳转
        let contents = model.contents ?? ""//btnClick 跳转
        if let url = type == "btnClick" ? contents : type == "cellClick" ? obvious : nil {
            judguUrlContainSche(url)
        }
    }
    
    @objc func loadOrderData() {
        let dict = ["eight": eight ?? ""]
        FCRequset.shared.requestAPI(params: dict, pageUrl: theyThem, method: .post) { [weak self] baseModel in
            let conceive =  baseModel.conceive
            let wanting =  baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelArray = model.palace
                    if modelArray != nil {
                        self?.removeNodataVeiw()
                    }else {
                        self?.addNodataView()
                    }
                    self?.orderView.modelArray = modelArray
                    self?.orderView.tableView.reloadData()
                }else {
                    self?.addNodataView()
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
            self?.orderView.tableView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            self?.orderView.tableView.mj_header?.endRefreshing()
        }
    }
    
    func addNodataView() {
        self.orderView.addSubview(self.nodataView)
        self.nodataView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func removeNodataVeiw() {
        self.nodataView.removeFromSuperview()
    }
    
}
