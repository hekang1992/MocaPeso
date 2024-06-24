//
//  FCFaceViewController.swift
//  FutureCash
//
//  Created by apple on 2024/5/7.
//

import UIKit
import HandyJSON
import AAILiveness
import MBProgressHUD
import Kingfisher
import AVFoundation

class FCFaceViewController: FCBaseViewController {
    
    var starttime: String?
    
    var particularly: String?
    
    lazy var faceView: FCFaceView = {
        let faceView = FCFaceView()
        return faceView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        starttime = DeviceInfo.getCurrentTime()
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addFaceView()
        faceView.block = { [weak self] in
            self?.getCishuFace()
        }
        faceView.block1 = { [weak self] in
            if let particularly = self?.particularly {
                self?.checkType(particularly, self?.starttime ?? "", "")
                self?.delayTime(1.0, closure: {
                    self?.getProductDetailInfo(particularly, self?.starttime ?? "", "")
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //获取用户身份信息
        getPersonCardInfo()
    }
}

extension FCFaceViewController {
    
    func addFaceView() {
        view.insertSubview(faceView, belowSubview: navView)
        faceView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func getCishuFace() {
        let dict = ["prove": "1", "shaking": "1"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: thoughtfully, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<FaceModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    self?.takeTapFace(model.stands ?? "")
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func takeTapFace(_ stands: String) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.sync {
                        self.checkLicense(stands)
                    }
                }
            }
        } else if status == .denied || status == .restricted {
            goCamera()
        } else {
            checkLicense(stands)
        }
    }

    func goCamera() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Permission Denied", message: "To continue using this feature, please enable camera access in your settings.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                print("Cancel")
            }
            let confirmAction = UIAlertAction(title: "Go to Settings", style: .destructive) { action in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        }
    }
    
    func checkLicense(_ stands: String) {
        let checkResult = AAILivenessSDK.configLicenseAndCheck(stands)
        if checkResult == "SUCCESS" {
            let faceVc = AAILivenessViewController()
            faceVc.detectionSuccessBlk = { [weak self] rawVC, result in
                let livenessId = result.livenessId
                let bestImg = result.img
                let data: Data = Data.compressImageQuality(image: bestImg, maxLength: 1024)!
                self?.saveFaceInfo(data, livenessId, rawVC)
            }
            let navVc = BaseNavViewController(rootViewController: faceVc)
            navVc.modalPresentationStyle = .fullScreen
            self.present(navVc, animated: true)
        }else if checkResult == "LICENSE_EXPIRE"{
            MBProgressHUD.show(text: "License Expired")
        }else if checkResult == "APPLICATION_ID_NOT_MATCH"{
            MBProgressHUD.show(text: "Application ID Does Not Match")
        }else {
            MBProgressHUD.show(text: "Unknown Error Occurred")
        }
    }
    
    func saveFaceInfo(_ data: Data, _ shirted: String, _ vc: AAILivenessViewController) {
        let standing = "2"
        let relations = particularly ?? "" //product id
        let excuse = "10"
        let dict = ["standing": standing,
                    "relations": relations,
                    "excuse": excuse,
                    "shirted": shirted,
                    "black": "3"] as [String: Any]
        FCRequset.shared.uploadImageAPI(params: dict, pageUrl: nothingYoumanner, method: .post, data: data) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                UIView.animate(withDuration: 0.25) {
                    vc.navigationController?.dismiss(animated: true, completion: {
                        //调用产品详情
                        if let particularly = self?.particularly {
                            self?.checkType(particularly, self?.starttime ?? "", "")
                            self?.delayTime(1.0, closure: {
                                self?.getProductDetailInfo(particularly, self?.starttime ?? "", "")
                                self?.miandian(productID: self?.particularly ?? "", startTime: self?.starttime ?? "", type: "4")
                            })
                        }
                    })
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func getPersonCardInfo() {
        let dict = ["relations": particularly ?? "", "hitch": "1"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: persuadedThere, method: .get) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<IDCradModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let shouldBeHidden = model.weren?.isEmpty ?? true
                    self?.faceView.changeBtn.isHidden = !shouldBeHidden
                    self?.faceView.changeBtn1.isHidden = shouldBeHidden
                    if !shouldBeHidden {
                        if let urlString = model.weren, let url = URL(string: urlString) {
                            let options: KingfisherOptionsInfo = [
                                .transition(.fade(0.2))
                            ]
                            self?.faceView.iconImageView4.kf.indicatorType = .activity
                            if let indicator = self?.faceView.iconImageView4.kf.indicator?.view as? UIActivityIndicatorView {
                                if #available(iOS 13.0, *) {
                                    indicator.style = .medium
                                }
                                indicator.color = .white
                            }
                            self?.faceView.iconImageView4.kf.setImage(with: url, options: options)
                        }
                    }
                }
            }
        } errorBlock: { error in
            
        }
    }
    
    func checkType(_ productID: String, _ startTime: String, _ type: String) {
        let dict = ["relations": productID, "proposed": "1", "happenings": "2"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: "/henryDidnt", method: .post) { baseModel in
            
        } errorBlock: { error in
            
        }
    }
    
}

