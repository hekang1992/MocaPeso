//
//  HomeViewController.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import MBProgressHUD
import HandyJSON
import MJRefresh
import TYAlertController

class HomeViewController: FCBaseViewController {
    
    var stranger: String?
    
    var particularly: String?
    
    var typeModel: FearedModel?
    
    var modelOrderArray: [PlaceModel]?
    
    lazy var oneView: FCHomeOneView = {
        let oneView = FCHomeOneView()
        return oneView
    }()
    
    lazy var twoView: FCHomeTwoView = {
        let twoView = FCHomeTwoView()
        return twoView
    }()
    
    lazy var rightView: RightView = {
        let rightView = RightView()
        return rightView
    }()
    
    lazy var secView: SecPopView = {
        let secView = SecPopView(frame: self.view.bounds)
        return secView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getAddressInfo()
        FCNotificationCenter.addObserver(self, selector: #selector(pushPesoUrl(_:)), name: NSNotification.Name(FCAPPLE_PARAMS), object: nil)

        oneView.block1 = { [weak self] in
            self?.applyClick(self?.particularly ?? "")
        }
        oneView.block2 = { [weak self] in
            if IS_LOGIN {
                self?.pushOrderVcWithTypeStr("9")
            }else {
                self?.addLoginView()
            }
        }
        oneView.block3 = { [weak self] in
            if IS_LOGIN {
                self?.addRightView()
            }else {
                self?.addLoginView()
            }
        }
        oneView.block4 = { [weak self] in
            self?.popSecView()
        }
        twoView.block1 = { [weak self] str in
            self?.judguUrlContainSche(str)
        }
        twoView.block2 = { [weak self] in
            self?.pushOrderVcWithTypeStr("9")
        }
        twoView.block3 = { [weak self] in
            self?.addRightView()
        }
        twoView.block4 = { [weak self] model in
            self?.applyClick(model.particularly ?? "")
        }
        self.twoView.tableView.mj_header = FCPullHeader(refreshingTarget: self, refreshingAction: #selector(loadHomeData))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeData()
        if IS_LOGIN {
            loadOrderData()
            loadOrderDaoqiData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideRightView()
    }
}

extension HomeViewController {
    
    func popSecView() {
        let alertVC = TYAlertController(alert: secView, preferredStyle: .actionSheet)
        self.present(alertVC!, animated: true)
        secView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                UserDefaults.standard.setValue("1", forKey: "isshow")
                UserDefaults.standard.synchronize()
            })            
        }
        secView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                UserDefaults.standard.setValue("1", forKey: "isshow")
                UserDefaults.standard.synchronize()
                let secVc = SecPopViewViewController()
                self?.navigationController?.pushViewController(secVc, animated: true)
            })            
        }
    }
    
    @objc func loadHomeData() {
        getHomeData()
        if IS_LOGIN {
            loadOrderData()
            loadOrderDaoqiData()
        }
    }
    
    func addOneView() {
        DispatchQueue.main.async { [self] in
            view.addSubview(oneView)
            oneView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func addTwoView() {
        DispatchQueue.main.async { [self] in
            view.addSubview(twoView)
            twoView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func addRightView() {
        view.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0))
        }
        rightView.block1 = { [weak self] in
            self?.hideRightView()
        }
        rightView.block2 = { [weak self] in
            self?.goSetVc()
        }
        rightView.block3 = { [weak self] in
            self?.pushWebVC(GetBaseApi.setBaseApiUrl()  + "/alfredWhatsername", "", "", "")
        }
        rightView.block4 = { [weak self] in
            self?.pushWebVC(GetBaseApi.setBaseApiUrl() + "/continuedDetected", "", "", "")
        }
        rightView.block5 = { [weak self] typeStr in
            self?.pushOrderVcWithTypeStr(typeStr)
        }
        rightView.block6 = {
            self.pushWebVC(GetBaseApi.setBaseApiUrl(), "", "", "")
        }
        rightView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if let typeModel = typeModel {
            rightView.typeModel = typeModel
        }
        if let modelOrderArray = modelOrderArray {
            rightView.numLabel.text = "\(String(describing: modelOrderArray.count))"
        }
        delayTime(0.25) { [weak self] in
            self?.animateRightView()
        }
    }
    
    func animateRightView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: .curveLinear) {
            self.rightView.alpha = 1
            self.rightView.bgImageView.snp.updateConstraints { make in
                make.left.equalToSuperview().offset(75.px())
            }
            self.rightView.layoutSubviews()
        }
    }
    
    func hideRightView() {
        UIView.animate(withDuration: 0.25) {
            self.rightView.alpha = 0
            self.rightView.bgImageView.snp.updateConstraints { make in
                make.left.equalToSuperview().offset(SCREEN_WIDTH)
            }
            self.rightView.layoutSubviews()
        }
    }
    
    func goSetVc() {
        let setVc = ProfileViewController()
        self.navigationController?.pushViewController(setVc, animated: true)
    }
    
    func getHomeData() {
        FCRequset.shared.requestAPI(params: [:], pageUrl: examined, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let bigCardModel = model.untidily?.reddening
                    let bannerModelArray = model.filthy?.reddening
                    let fudaiModelArray = model.retired?.reddening
                    let productArray = model.palaced?.reddening
                    if let typeModel = model.feared {
                        self?.typeModel = typeModel
                        self?.rightView.oneView.typeModel = typeModel
                        self?.rightView.oneView.tableView.reloadData()
                    }
                    if let bigCardModel = bigCardModel {
                        self?.particularly = bigCardModel.particularly
                        self?.twoView.removeFromSuperview()
                        self?.addOneView()
                        self?.oneView.model = bigCardModel
                    }else {
                        if let bannerModelArray = bannerModelArray {
                            self?.oneView.removeFromSuperview()
                            self?.addTwoView()
                            self?.twoView.modelBannerArray = bannerModelArray
                            self?.twoView.productArray = productArray
                            self?.twoView.fudaiBannerArray = fudaiModelArray
                            self?.twoView.pagerView1.reloadData()
                            self?.twoView.pagerView2.reloadData()
                            self?.twoView.tableView.reloadData()
                        }
                    }
                    let stranger = model.stranger ?? ""//fake product
                    if stranger == "1" {
                        let isShow: String = UserDefaults.standard.object(forKey: "isshow") as? String ?? ""
                        if isShow != "1" {
//                            self?.popSecView()
                        }
                    }
                }
            }else {
            }
            self?.twoView.tableView.mj_header?.endRefreshing()
        } errorBlock: { [weak self] error in
            self?.twoView.tableView.mj_header?.endRefreshing()
        }
    }
    
    func getAddressInfo() {
        FCRequset.shared.requestAPI(params: [:], pageUrl: troubleObviously, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model, let modelArray = model.palace, let jsonString = modelArray.toJSONString() {
                    self?.saveDataToLocalFile(jsonString, fileName: "palaceData.json")
                }
            }
        } errorBlock: { error in
            
        }
    }
    
    func loadOrderData() {
        let dict = ["eight": "6"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: theyThem, method: .post) { [weak self] baseModel in
            let conceive =  baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelOrderArray = model.palace
                    self?.modelOrderArray = modelOrderArray
                }
            }
        } errorBlock: { error in
        }
    }
    
    func loadOrderDaoqiData() {
        let dict = ["eight": "9"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: theyThem, method: .post) { [weak self] baseModel in
            let conceive =  baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelOrderArray = model.palace
                    self?.oneView.numLabel.text = "\(String(modelOrderArray?.count ?? 0))"
                    self?.twoView.numLabel.text = "\(String(modelOrderArray?.count ?? 0))"
                }
            }
        } errorBlock: { error in
        }
    }
    
    func pushOrderVcWithTypeStr(_ str: String) {
        let orderVc = OrderViewController()
        orderVc.eight = str
        self.navigationController?.pushViewController(orderVc, animated: true)
    }
    
    @objc func pushPesoUrl(_ notification: Notification) {
        if let dict = notification.userInfo, let url = dict["params"] {
            pushToVc(url as! String)
        }
    }
    
    func pushToVc(_ url: String) {
        let currentVc = UIViewController.getCurrentUIVC() as! FCBaseViewController
        if url.contains(SCHEME_URL) {
            if url.contains("quiteMorley") {//产品详情
                let array = url.components(separatedBy: "relations=")
                currentVc.applyClick(array.last ?? "")
            }else if url.contains("spreadFloor") {
                let array = url.components(separatedBy: "blackened=")
                let orderVc = OrderViewController()
                orderVc.eight = array.last
                currentVc.navigationController?.pushViewController(orderVc, animated: true)
            }else if url.contains("flungMurmuring") {
                if !currentVc.isKind(of: HomeViewController.self) {
                    currentVc.navigationController?.popToRootViewController(animated: true)
                }
            }else if url.contains("werentFigured") {
                if !IS_LOGIN {
                    currentVc.addLoginView()
                }
            }
        }else {
            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                currentVc.pushWebVC(url, "", "", "")
            }
        }
    }
    
}
