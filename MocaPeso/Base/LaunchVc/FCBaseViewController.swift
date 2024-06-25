//
//  TLBaseViewController.swift
//  FutureCash
//
//  Created by apple on 2024/3/25.
//

import UIKit
import MBProgressHUD
import HandyJSON
import AdSupport
import TYAlertController

class FCBaseViewController: UIViewController {
    
    var totalTime = 60
    var countdownTimer: Timer!
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    lazy var navView: FCNavView = {
        let navView = FCNavView()
        navView.isHidden = true
        return navView
    }()
    
    lazy var sureFakeView: FCFakePopView = {
        let sureFakeView = FCFakePopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        return sureFakeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addNavView()
        view.backgroundColor = .white
        navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideLoginView()
    }
    
    func addNavView() {
        let heights = FCBaseViewController.getTopBarHeights(for: self)
        view.addSubview(navView)
        navView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(heights.totalHeight.px())
        }
    }
    
    func delayTime(_ delay: TimeInterval, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    func addLoginView() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(loginView)
        }
//        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.block1 = { [weak self] in
            self?.hideLoginView()
        }
        loginView.block2 = { [weak self] in
            self?.loginInfo()
        }
        loginView.block3 = { [weak self] in
            self?.getCode()
        }
        loginView.block4 = { [weak self] in
            self?.pushWebVC( GetBaseApi.setBaseApiUrl()  + "/alfredWhatsername", "", "", "")
        }
        delayTime(0.25) { [weak self] in
            self?.animateLoginView()
        }
    }
    
    func hideLoginView() {
        self.loginView.phoneTed.text = ""
        self.loginView.codeView.deleteCodeStr()
        self.loginView.isHidden = true
        self.loginView.codeView.hideTextField.resignFirstResponder()
        self.loginView.phoneTed.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.loginView.bgImageView.snp.updateConstraints { make in
                make.left.equalTo(self.loginView.bgView).offset(SCREEN_WIDTH)
            }
            self.loginView.layoutIfNeeded()
        }
    }
    
    func animateLoginView() {
        self.loginView.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.loginView.bgImageView.snp.updateConstraints { make in
                make.left.equalTo(self.loginView.bgView).offset(28.px())
            }
            self.loginView.layoutIfNeeded()
        }
    }
    
    func loginInfo() {
        let phoneStr = self.loginView.phoneTed.text ?? ""
        let codeStr = self.loginView.verifyCode
        if phoneStr.isEmpty {
            MBProgressHUD.show(text: "Please enter your phone number.")
        }else if codeStr.isEmpty {
            MBProgressHUD.show(text: "Please enter the verification code.")
        }else {
            self.walkedLogin()
        }
    }
    
    func getCode() {
        let phoneStr = self.loginView.phoneTed.text ?? ""
        if phoneStr.isEmpty {
            MBProgressHUD.show(text: "Please enter your phone number.")
        }else {
            self.horoughly(phoneStr)
        }
    }
    
    func startTimer() {
        self.loginView.btn2.isEnabled = false
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime > 0 {
            totalTime -= 1
            self.loginView.btn2.setTitle("\(self.totalTime)", for: .normal)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        self.loginView.btn2.isEnabled = true
        self.loginView.btn2.setTitle("Send", for: .normal)
        totalTime = 60
    }
    
    func getApplePush() {
        FCNotificationCenter.post(name: NSNotification.Name(FCAPPLE_PUSH), object: nil)
    }
    
    func getAppleGoogle() {
        FCNotificationCenter.post(name: NSNotification.Name(FCAPPLE_GOOGLE), object: nil)
    }
    
    func getAppleLocation() {
        FCNotificationCenter.post(name: NSNotification.Name(FCAPPLE_LOCATION), object: nil)
    }
    
    func getRootVcPush() {
        FCNotificationCenter.post(name: NSNotification.Name(FCAPPLE_ROOT_VC), object: nil)
    }
    
}

extension FCBaseViewController: UINavigationControllerDelegate {
    
    func saveDataToLocalFile(_ jsonString: String, fileName: String) {
        guard let data = jsonString.data(using: .utf8) else { return }
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to write JSON data to local file: \(error.localizedDescription)")
        }
    }
    
    func loadDataFromLocalFile(fileName: String) -> [PlaceModel]? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            if let jsonString = String(data: data, encoding: .utf8) {
                return convertJsonStringToModel(jsonString: jsonString)
            }
        } catch {
            print("Failed to read from local file: \(error.localizedDescription)")
        }
        return nil
    }
    
    func convertJsonStringToModel(jsonString: String) -> [PlaceModel]? {
        return [PlaceModel].deserialize(from: jsonString) as? [PlaceModel]
    }
    
    func applyClick(_ productID: String) {
        let dict = ["relations": productID]
        FCRequset.shared.requestAPI(params: dict, pageUrl: haveHeard, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let weren = model.weren ?? ""
                    self?.judguUrlContainSche(weren)
                }
            }
        } errorBlock: { error in
            
        }
    }
    
    func horoughly(_ phone: String) {
        let dict = ["judge": phone, "killing": "1"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: rightThoroughly, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            MBProgressHUD.show(text: wanting)
            if conceive == 0 || conceive == 00 {
                self?.startTimer()
            }
        } errorBlock: { error in
            
        }
    }
    
    //登陆
    func walkedLogin() {
        let starttime = DeviceInfo.getCurrentTime()
        let phoneStr = self.loginView.phoneTed.text ?? ""
        let codeStr = self.loginView.verifyCode
        let dict = ["temperance": phoneStr, "females": codeStr, "suggest": "1"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: walkedWhole, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            MBProgressHUD.show(text: wanting)
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<LoginModel>.deserializeFrom(dict: baseModel.easily)
                guard let model = model else { return }
                LoginFactory.saveLoginInfo(model.temperance ?? "", model.temple ?? "")
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self?.miandian(productID: "", startTime: starttime, type: "1")
                    }                    
                }
                self?.getAppleLocation()
                self?.getRootVcPush()
            }
        } errorBlock: { error in
            
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func getProductDetailInfo(_ productID: String, _ startTime: String, _ type: String) {
        let dict = ["relations": productID, "proposed": "1", "happenings": "2"]
        FCRequset.shared.requestAPI(params: dict, pageUrl: henry, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    let enjoyment = model.feared?.enjoyment as? String ?? ""
                    let suffused = model.given?.suffused as? String ?? ""
                    if !enjoyment.isEmpty {
                        self?.pushNextVc(model.feared?.enjoyment ?? "", productID, startTime)
                    }else {
                        self?.orderIDWithNext(suffused, productID, startTime, type)
                        self?.miandian(productID: productID, startTime: startTime, type: "9")
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func pushNextVc(_ type: String, _ productID: String, _ startTime: String) {
        if productID == "2" {//假茶品
            self.alertPopTypeFackView(type, productID, startTime)
        }else {
            self.nextVc(type, productID, startTime)
        }
    }
    
    func alertPopTypeFackView(_ type: String, _ productID: String, _ startTime: String) {
        let alertVC = TYAlertController(alert: sureFakeView, preferredStyle: .actionSheet)
        switch type {
        case "ua":
            sureFakeView.idImageView.image = UIImage(named: "liuchen1")
            sureFakeView.label1.text = "Next Step"
            sureFakeView.label2.text = "Identity and Facial Information"
            sureFakeView.label3.text = "1. To proceed, please complete the verification process. This step is crucial to prevent fraud and ensure the security of your funds during transactions.\n2. We prioritize the security of your personal information and will strictly safeguard your privacy.\n3. Thank you for your understanding and cooperation. If you have any questions or need assistance, feel free to contact our customer service team at any time."
            break
            
        case "ea":
            sureFakeView.idImageView.image = UIImage(named: "liuchen2")
            sureFakeView.label1.text = "Next Step"
            sureFakeView.label2.text = "Personal Information"
            sureFakeView.label3.text = "1. Gender: Used for personalized marketing and product customization.\n2. Education: Reflects qualifications and income for credit assessment.\n3. Email: Enables communication and notifications.\n4. Home Address: Confirms residence and provides contact details.\nCollecting this information helps assess credit risk and ensure secure loan processing, while complying with privacy regulations."
            break

        case "ww":
            sureFakeView.idImageView.image = UIImage(named: "liuchen3")
            sureFakeView.label1.text = "Next Step"
            sureFakeView.label2.text = "Bank Information"
            sureFakeView.label3.text = "1. Collecting users' bank card information is to deposit the loan funds directly into their bank accounts to complete the loan disbursement process.\n2. Loan institutions enforce strict security measures and privacy protections to safeguard users' bank card information.\n3. Using advanced encryption technologies to secure sensitive bank card information during transmission and storage, ensuring it remains unreadable to unauthorized parties."
            break
            
        default: 
            break
            
        }
        self.present(alertVC!, animated: true)
        sureFakeView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        sureFakeView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.nextVc(type, productID, startTime)
            })
        }
    }
    
    func nextVc(_ type: String, _ productID: String, _ startTime: String) {
        switch type {
        case "ua":
            getIDType(productID)
            break
            
        case "ea":
            let peronalVc = FCPersonalInfoViewController()
            peronalVc.particularly = productID
            self.navigationController?.pushViewController(peronalVc, animated: true)
            break
            
        case "ef":
            let workVc = FCWorkInfoViewController()
            workVc.particularly = productID
            self.navigationController?.pushViewController(workVc, animated: true)
            break
            
        case "ee":
            let contactVc = FCContactViewController()
            contactVc.particularly = productID
            self.navigationController?.pushViewController(contactVc, animated: true)
            break
            
        case "ww":
            let bankVc = FCBankInfoViewController()
            bankVc.particularly = productID
            self.navigationController?.pushViewController(bankVc, animated: true)
            break
            
        default: break
            
        }
    }
    
    func getIDType(_ productID: String) {
        if productID == "2" {
            let cardVc = FCCardTypeViewController()
            cardVc.particularly = productID
            self.navigationController?.pushViewController(cardVc, animated: true)
        }else {
            let dict = ["relations": productID, "hitch": "1"]
            FCRequset.shared.requestAPI(params: dict, pageUrl: persuadedThere, method: .get) { [weak self] baseModel in
                let conceive = baseModel.conceive
                if conceive == 0 || conceive == 00 {
                    let model = JSONDeserializer<IDCradModel>.deserializeFrom(dict: baseModel.easily)
                    if let model = model {
                        let shouldBeHidden = model.waved?.weren?.isEmpty ?? true
                        if !shouldBeHidden {
                            let photoVc = FCPhotoViewController()
                            photoVc.particularly = productID
                            self?.navigationController?.pushViewController(photoVc, animated: true)
                        }else {
                            let cardVc = FCCardTypeViewController()
                            cardVc.particularly = productID
                            self?.navigationController?.pushViewController(cardVc, animated: true)
                        }
                    }
                }
            } errorBlock: { error in
                
            }
        }
    }
    
    func orderIDWithNext(_ orderID: String, _ productID: String, _ startTime: String, _ type: String) {
        let dict = ["holborn": orderID]
        FCRequset.shared.requestAPI(params: dict, pageUrl: alfredsConscious, method: .post) { [weak self] baseModel in
            let conceive = baseModel.conceive
            let wanting = baseModel.wanting ?? ""
            if conceive == 0 || conceive == 00 {
                let model = JSONDeserializer<EasilyModel>.deserializeFrom(dict: baseModel.easily)
                if let model = model {
                    if productID == "2" {
                        self?.confirmPopView(model.weren ?? "", productID, startTime, type)
                    }else {
                        self?.pushWebVC(model.weren ?? "", productID, startTime, type)
                    }
                }
            }else {
                MBProgressHUD.show(text: wanting)
            }
        } errorBlock: { error in
            
        }
    }
    
    func confirmPopView(_ url: String, _ productID: String, _ startTime: String, _ type: String) {
        let alertVC = TYAlertController(alert: sureFakeView, preferredStyle: .actionSheet)
        sureFakeView.btn.isHidden = true
        sureFakeView.idImageView.image = UIImage(named: "liuchen4")
        sureFakeView.label1.text = "Verification Completed"
        sureFakeView.label2.text = "Done!"
        sureFakeView.label3.text = "1. Your verification process is complete. Thank you for your patience. Please click 'Confirm' to confirm your loan details.\n2. Processing your application may take some time. We will handle it promptly to ensure you receive your funds as soon as possible.\n3. The review results will be sent via SMS and email. Please check your messages. For any questions, contact our customer service team. Thank you for your support."
        self.present(alertVC!, animated: true)
        sureFakeView.block = { [weak self] in
            self?.dismiss(animated: true)
        }
        sureFakeView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.pushWebVC(url, productID, startTime, type)
            })
        }
    }
    
    func pushWebVC(_ url: String, _ productID: String, _ startTime: String, _ type: String) {
        let webVc = WebViewController()
        var urlString: String?
        if url.contains("?") {
            urlString = url + "&" + LoginFactory.getLoginParas()
        }else {
            urlString = url + "?" + LoginFactory.getLoginParas()
        }
        let stringWithoutSpaces = urlString?.replacingOccurrences(of: " ", with: "%20")
        webVc.productUrl = stringWithoutSpaces
        webVc.type = type
        navigationController?.pushViewController(webVc, animated: true)
    }
    
    func miandian(productID: String, startTime: String, type: String) {
        let model = LocationManager.shared.locatinModel
        let smell = productID
        let skilled = type
        let unsatisfactory = DeviceInfo.getIdfv()
        let politics = DeviceInfo.getIDFA()
        let needed = model.longitude
        let alcoholic = model.latitude
        let arguing = startTime
        let liked = DeviceInfo.getCurrentTime()
        let dict = ["smell": smell, 
                    "skilled": skilled,
                    "unsatisfactory": unsatisfactory,
                    "politics": politics,
                    "needed": needed,
                    "alcoholic": alcoholic,
                    "arguing": arguing,
                    "liked": liked] as [String: Any]
        FCRequset.shared.requestAPI(params: dict, pageUrl: theBrother, method: .post) { baseModel in
           let conceive = baseModel.conceive
            if conceive == 0 || conceive == 00 {
                print("🚗埋点>>>\(type)>>>success🚗")
            }
        } errorBlock: { error in
            
        }
    }
    
    func judguUrlContainSche(_ url: String) {
        if url.contains(SCHEME_URL) {
            if url.contains("gleamingStaying") {
                let againVc = FCAgainBuyViewController()
                self.navigationController?.pushViewController(againVc, animated: true)
            }else if url.contains("quiteMorley"){
                let array = url.components(separatedBy: "relations=")
                self.getProductDetailInfo(array.last ?? "", "", "")
            }else {
                
            }
        }else{
            if !url.isEmpty {
                self.pushWebVC(url, "", "", "")
            }
        }
    }
    
}
