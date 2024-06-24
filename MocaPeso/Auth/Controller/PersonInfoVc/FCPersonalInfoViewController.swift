//
//  FCPersonalInfoViewController.swift
//  FutureCash
//
//  Created by apple on 2024/5/8.
//

import UIKit
import MBProgressHUD
import HandyJSON
import TYAlertController
import BRPickerView

class FCPersonalInfoViewController: FCBaseViewController {
    
    var starttime: String?
    
    var particularly: String?
    
    lazy var personalView: FCPersonalView = {
        let personalView = FCPersonalView()
        personalView.iconImageView2.image = UIImage(named: "personalImage")
        return personalView
    }()
    
    lazy var popView: FCPopPersonView = {
        let popView = FCPopPersonView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        return popView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        starttime = DeviceInfo.getCurrentTime()
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addPersonalView()
        personalView.block = { [weak self] dict in
            dict["relations"] = self?.particularly
            self?.savePersonalInfo(dict)
        }
        personalView.block1 = { [weak self] cell,model in
            self?.alertNormalEnum(cell, model)
        }
        personalView.block2 = { [weak self] cell,model in
            self?.alertCity(cell, model)
        }
        personalView.block3 = { [weak self] cell,model in
            self?.alertPaydayView(cell, model)
        }
        getPersonalInfo()
    }
}

extension FCPersonalInfoViewController {
    
    func addPersonalView() {
        view.insertSubview(personalView, belowSubview: navView)
        personalView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func getPersonalInfo() {
        let dict = ["relations": particularly ?? ""]
        FCRequset.shared.requestAPI(params: dict, pageUrl: brotherIndecisively, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelArray = model.except
                    if let modelArray = modelArray {
                        self?.personalView.modelArray = modelArray
                        self?.personalView.tableView.reloadData()
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func alertNormalEnum(_ cell: FCWenBenCell, _ emodel: ExceptModel) {
        let alertVC = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        if let children = emodel.children {
            popView.modelArray = children
            popView.tableView.reloadData()
        }
        self.present(alertVC!, animated: true)
        popView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        popView.block1 = { [weak self] model in
            self?.delayTime(0.25, closure: {
                self?.dismiss(animated: true, completion: {
                    emodel.sapped = model.employment
                    emodel.excuse = model.excuse
                    cell.nameField.text = model.employment
                })
            })
        }
    }
    
    func alertCity(_ cell: FCWenBenCell, _ model: ExceptModel) {
        if let placeModels = loadDataFromLocalFile(fileName: "palaceData.json") {
            let modelArray = ProvinceModelConverter.getProvinceModelArr(dataSourceArr: placeModels)
            popEnumCityView(cell, modelArray, model)
        } else {
            print("Failed to load place models from the file.")
        }
    }
    
    func popEnumCityView(_ cell: FCWenBenCell, _ array: [BRProvinceModel], _ model: ExceptModel) {
        let addressPickerView = BRAddressPickerView()
        addressPickerView.pickerMode = .area
        addressPickerView.title = "Please Select Region"
        addressPickerView.dataSourceArr = array
        addressPickerView.selectIndexs = [0, 0, 0]
        addressPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let areaName = area?.name ?? ""
            let addressString = provinceName + " - " + cityName + " - " + areaName
            model.sapped = addressString
            model.excuse = addressString
            cell.nameField.text = model.sapped
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: Fredoka_Bold, size: 18.px())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.red
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }
    
    func alertPaydayView(_ cell: FCWenBenCell, _ model: ExceptModel) {
        if let modelArray = model.children {
            let paydayArray = GetPayday.getPaydayModelArr(dataSourceArr: modelArray)
            popEnumPaydayView(cell, paydayArray, model)
        }
    }
    
    func popEnumPaydayView(_ cell: FCWenBenCell, _ array: [BRProvinceModel], _ model: ExceptModel) {
        let addressPickerView = BRAddressPickerView()
        addressPickerView.pickerMode = .city
        addressPickerView.title = "Please Select Payday"
        addressPickerView.dataSourceArr = array
        addressPickerView.selectIndexs = [0, 0, 0]
        addressPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let provinceCode = province?.code ?? ""
            let cityCode = city?.code ?? ""
            let addressString = provinceName + " | " + cityName
            model.sapped = addressString
            cell.nameField.text = addressString
            model.excuse = provinceCode + "|" + cityCode
            print("🔥model.excuse>>>>>>🔥\(model.excuse ?? "")")
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: Fredoka_Bold, size: 18.px())
        customStyle.selectRowTextFont = customStyle.pickerTextFont
        customStyle.selectRowTextColor = UIColor.red
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }
    
    func savePersonalInfo(_ dict: [String: Any]) {
        FCRequset.shared.requestAPI(params: dict, pageUrl: theTime, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                self?.getProductDetailInfo(self?.particularly ?? "", self?.starttime ?? "", "")
                self?.miandian(productID: self?.particularly ?? "", startTime: self?.starttime ?? "", type: "5")
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
}

