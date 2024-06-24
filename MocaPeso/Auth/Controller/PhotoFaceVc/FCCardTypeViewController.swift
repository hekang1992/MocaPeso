//
//  FCCardTypeViewController.swift
//  FutureCash
//
//  Created by apple on 2024/4/26.
//

import UIKit
import HandyJSON
import TYAlertController
import MBProgressHUD

class FCCardTypeViewController: FCBaseViewController {
    
    var starttime: String?
    
    var modelArray: [PModel]?
    
    var particularly: String?
    
    lazy var typeView: CardTypeView = {
        let typeView = CardTypeView()
        return typeView
    }()
    
    lazy var changeView: ChangeTypeView = {
        let changeView = ChangeTypeView(frame: self.view.bounds)
        return changeView
    }()
    
    lazy var sureView: TypeSureView = {
        let sureView = TypeSureView(frame: self.view.bounds)
        return sureView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starttime = DeviceInfo.getCurrentTime()
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        addTypeView()
        getCardPic()
        typeView.block = { [weak self] in
            self?.popTypeView()
        }
        typeView.block1 = { [weak self] model,typeView,indexpath in
            self?.selectTypeView(model,typeView,indexpath)
        }
    }
}

extension FCCardTypeViewController {
    
    func addTypeView() {
        view.insertSubview(typeView, belowSubview: navView)
        typeView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func popTypeView() {
        let alertVC = TYAlertController(alert: changeView, preferredStyle: .actionSheet)
        if let modelArray = self.modelArray {
            changeView.modelArray = modelArray
            changeView.collectionView.reloadData()
        }
        self.present(alertVC!, animated: true)
        changeView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        changeView.block1 = { [weak self] model in
            self?.dismiss(animated: true, completion: {
                self?.selectTypeView(model, CardTypeView(), IndexPath())
            })
        }
    }
    
    func selectTypeView(_ model: PModel, _ col: CardTypeView, _ indexPath: IndexPath) {
        let alertVC = TYAlertController(alert: sureView, preferredStyle: .actionSheet)
        sureView.label2.text = model.excuse
        let imageUrl = URL(string: model.yewtiful ?? "")
        sureView.idImageView.kf.setImage(with: imageUrl)
        self.present(alertVC!, animated: true)
        sureView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                col.didselectCollecTionView(col.collectionView, indexPath)
            })
        }
        sureView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                col.didselectCollecTionView(col.collectionView, indexPath)
                self?.delayTime(0.15) {
                    self?.popTypeView()
                }
            })
        }
        sureView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                col.didselectCollecTionView(col.collectionView, indexPath)
                self?.delayTime(0.15, closure: {
                    let photoVc = FCPhotoViewController()
                    photoVc.guessed = model.excuse
                    photoVc.imageUrl = model.yewtiful
                    photoVc.particularly = self?.particularly ?? ""
                    self?.miandian(productID: self?.particularly ?? "", startTime: self?.starttime ?? "", type: "2")
                    self?.navigationController?.pushViewController(photoVc, animated: true)
                })
            })
        }
    }
    
    func getCardPic() {
        let dict = ["relations": particularly ?? ""]
        FCRequset.shared.requestAPI(params: dict, pageUrl: wnnjennn, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<CardTypeModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    self?.modelArray = model.pwpnnemw
                    self?.typeView.modelArray = model.pwpnnemw
                    self?.typeView.collectionView.reloadData()
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
        
    }
    
}
