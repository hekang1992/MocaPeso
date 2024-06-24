//
//  FCContactViewController.swift
//  FutureCash
//
//  Created by apple on 2024/5/8.
//

import UIKit
import HandyJSON
import MBProgressHUD
import TYAlertController
import ContactsUI

class FCContactViewController: FCBaseViewController {
    
    var starttime: String?
    
    var particularly: String?
    
    var lastSelectedCell: FCContactCell?
    
    var model: ExceptModel?
    
    lazy var contactView: FCContactView = {
        let contactView = FCContactView()
        contactView.iconImageView2.image = UIImage(named: "contactInfo")
        return contactView
    }()
    
    lazy var popView: FCPopPersonView = {
        let popView = FCPopPersonView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        return popView
    }()
    
    lazy var pickerVc: CNContactPickerViewController = {
        let pickerVc = CNContactPickerViewController()
        pickerVc.delegate = self
        pickerVc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return pickerVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        starttime = DeviceInfo.getCurrentTime()
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        addContactView()
        contactView.block = { [weak self] array in
            self?.saveContactInfo(array)
        }
        contactView.block1 = { [weak self] cell,model in
            self?.alertEnumView(cell, model)
        }
        contactView.block2 = { [weak self] cell,model in
            self?.alertContact(cell, model)
        }
        getContactInfo()
    }
}

extension FCContactViewController: CNContactPickerDelegate{
    
    func addContactView() {
        view.insertSubview(contactView, belowSubview: navView)
        contactView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func getContactInfo() {
        let dict = ["relations": particularly ?? ""]
        FCRequset.shared.requestAPI(params: dict, pageUrl: victimsInstrument, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let modelArray = model.eleven?.palace
                    if let modelArray = modelArray {
                        self?.contactView.modelArray = modelArray
                        self?.contactView.tableView.reloadData()
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func alertEnumView(_ cell: FCContactCell, _ emodel: ExceptModel) {
        let alertVC = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        if let children = emodel.elderly {
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
                    cell.model?.sapped = model.employment
                    cell.model?.square = model.excuse
                    cell.model?.Jorjjty = model.employment
                    cell.textField1.text = cell.model?.Jorjjty
                })
            })
        }
    }
    
    func alertContact(_ cell: FCContactCell, _ emodel: ExceptModel) {
        lastSelectedCell = cell
        present(pickerVc, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let nameStr = contact.givenName + " " + contact.familyName
        if let phoneNumber = contact.phoneNumbers.first?.value {
            let numberStr = phoneNumber.stringValue
            if let cell = lastSelectedCell {
                cell.textField2.text = nameStr
                cell.textField3.text = numberStr
                cell.model?.employment = nameStr
                cell.model?.lowndes = numberStr
            }
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact selection canceled")
    }
    
    func saveContactInfo(_ dictionaryArray: [[String: Any]]) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionaryArray, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8), let particularly = particularly {
                let dict = ["relations": particularly, "easily": jsonString]
                FCRequset.shared.uploadDataAPI(params: dict, pageUrl: heAfter, method: .post) { [weak self] baseModel in
                    let conceive = baseModel.conceive
                    let wanting = baseModel.wanting ?? ""
                    if conceive == 0 || conceive == 00 {
                        self?.getProductDetailInfo(self?.particularly ?? "", self?.starttime ?? "", "")
                        self?.miandian(productID: self?.particularly ?? "", startTime: self?.starttime ?? "", type: "7")
                    }else {
                        MBProgressHUD.show(text: wanting)
                    }
                } errorBlock: { error in
                    
                }
            } else {
                print("Failed to convert JSON data to string.")
            }
        } else {
            print("Failed to convert dictionary array to JSON data.")
        }
    }
    
    
}
