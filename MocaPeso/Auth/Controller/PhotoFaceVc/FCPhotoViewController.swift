//
//  FCPhotoViewController.swift
//  FutureCash
//
//  Created by apple on 2024/5/6.
//

import UIKit
import Kingfisher
import AVFoundation
import Photos
import HandyJSON
import TYAlertController
import MBProgressHUD

typealias CompletionStatusBlock = (Bool) -> Void
class FCPhotoViewController: FCBaseViewController {
    
    var starttime: String = ""
    
    var imageUrl: String?
    
    var guessed: String?
    
    var particularly: String?
    
    lazy var photoView: FCPhotoView = {
        let photoView = FCPhotoView()
        photoView.iconImageView3.kf.setImage(with: URL(string: imageUrl ?? ""))
        return photoView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    lazy var cardInfoView: FCPopCardInfoView = {
        let cardInfoView = FCPopCardInfoView(frame: self.view.bounds)
        return cardInfoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        starttime = DeviceInfo.getCurrentTime()
        self.navView.isHidden = false
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        addPhotoView()
        photoView.nextBlock = { [weak self] in
            self?.goFaceVc()
        }
        photoView.albumBlock = { [weak self] in
            self?.albumClick()
        }
        photoView.cameraBlock = { [weak self] in
            self?.cameraClick()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //获取用户身份信息
        getPersonCardInfo()
    }
}

extension FCPhotoViewController: UIImagePickerControllerDelegate {
    
    func addPhotoView() {
        view.insertSubview(photoView, belowSubview: navView)
        photoView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func albumClick() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            checkPhotoStatus { [weak self] (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self?.imagePicker.sourceType = .photoLibrary
                        if let imagePicker = self?.imagePicker{
                            self?.present(imagePicker, animated: true, completion: nil)
                        }
                    }
                }else {
                    self?.showAlert()
                }
            }
            
        } else {
            self.showAlert()
            print("Device doesn't support photo library.")
        }
    }
    
    func checkPhotoStatus(completion: @escaping CompletionStatusBlock) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            self.showAlert()
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        case .limited:
            completion(true)
        @unknown default:
            self.showAlert()
            completion(false)
        }
    }
    
    func cameraClick() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            checkCameraStatus { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.imagePicker.sourceType = .camera
                        self?.present(self!.imagePicker, animated: true)
                    }
                } else {
                    
                }
            }
        } else {
            print("Device doesn't support camera.")
        }
    }
    
    func checkCameraStatus(completion: @escaping CompletionStatusBlock) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            self.showAlert()
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                completion(granted)
            }
        @unknown default:
            self.showAlert()
            completion(false)
        }
    }
    
    func showAlert() {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = Data.compressImageQuality(image: image!, maxLength: 1200)
        picker.dismiss(animated: true) { [weak self] in
            self?.setUpLoadImage(data!,image!)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setUpLoadImage(_ data: Data, _ image: UIImage) {
        let standing = "1"
        let relations = particularly ?? "" //product id
        let excuse = "11"
        let guessed = guessed ?? "" //证件类型
        let dict = ["standing": standing,
                    "relations": relations,
                    "excuse": excuse,
                    "guessed": guessed] as [String: Any]
        FCRequset.shared.uploadImageAPI(params: dict, pageUrl: nothingYoumanner, method: .post, data: data) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting
            if conceive == 0 || conceive == 00 {
                let cardModel = JSONDeserializer<CardInfoModel>.deserializeFrom(dict: baseModel.easily)
                if let cardModel = cardModel {
                    UIView.animate(withDuration: 0.25) {
                        self?.popCardInfoView(cardModel,self?.imageUrl ?? "")
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting ?? "")
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
                    let shouldBeHidden = model.waved?.weren?.isEmpty ?? true
                    self?.photoView.albumBtn.isHidden = !shouldBeHidden
                    self?.photoView.cameraBtn.isHidden = !shouldBeHidden
                    self?.photoView.nextBtn.isHidden = shouldBeHidden
                    if !shouldBeHidden {
                        if let urlString = model.waved?.weren, let url = URL(string: urlString) {
                            let options: KingfisherOptionsInfo = [
                                .transition(.fade(0.2))
                            ]
                            self?.photoView.iconImageView3.kf.indicatorType = .activity
                            if let indicator = self?.photoView.iconImageView3.kf.indicator?.view as? UIActivityIndicatorView {
                                if #available(iOS 13.0, *) {
                                    indicator.style = .medium
                                }
                                indicator.color = .white
                            }
                            self?.photoView.iconImageView4.isHidden = true
                            self?.photoView.iconImageView3.kf.setImage(with: url, options: options)
                        }
                    }
                }
            }
        } errorBlock: { error in
            
        }
    }
    
}

extension FCPhotoViewController {
    
    func popCardInfoView(_ model: CardInfoModel, _ imageUrl: String) {
        let alertVC = TYAlertController(alert: cardInfoView, preferredStyle: .actionSheet)
        cardInfoView.idImageView.kf.setImage(with: URL(string: imageUrl))
        cardInfoView.nameView1.nameField.text = model.employment ?? ""
        cardInfoView.nameView2.nameField.text = model.thorough ?? ""
        let year = model.telephoned ?? ""
        let mon = model.frauds ?? ""
        let day = model.ingenious ?? ""
        let dateStr = day + "-" + mon + "-" + year
        cardInfoView.model = model
        cardInfoView.nameView3.nameField.text = dateStr
        self.present(alertVC!, animated: true)
        cardInfoView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        cardInfoView.block1 = {[weak self] in
            self?.saveCardInfo()
        }
    }
    
    func saveCardInfo() {
        let employment = cardInfoView.nameView1.nameField.text ?? ""
        let thorough = cardInfoView.nameView2.nameField.text ?? ""
        let intended = cardInfoView.nameView3.nameField.text ?? ""
        let timeArray = intended.components(separatedBy: "-")
        let year = timeArray[2]
        let mon = timeArray[1]
        let day = timeArray[0]
        let dateStr = String(format: "%@-%@-%@", year,mon,day)
        let dict = ["employment": employment,
                    "thorough": thorough,
                    "intended": dateStr,
                    "guessed": guessed ?? "",
                    "teaser": "1",
                    "excuse": "11"] as [String : Any]
        FCRequset.shared.requestAPI(params: dict, pageUrl: gettingOclock, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                self?.dismiss(animated: true, completion: {
                    self?.goFaceVc()
                })
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func goFaceVc() {
        let faceVc = FCFaceViewController()
        faceVc.particularly = self.particularly ?? ""
        self.navigationController?.pushViewController(faceVc, animated: true)
        self.miandian(productID: self.particularly ?? "", startTime: starttime, type: "3")
    }
    
}
