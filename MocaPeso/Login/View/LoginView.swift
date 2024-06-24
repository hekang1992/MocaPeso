//
//  LoginView.swift
//  FutureCash
//
//  Created by apple on 2024/3/26.
//

import UIKit
import UIColor_Hex
import MBProgressHUD

typealias LoginCanBlock = () -> Void
class LoginView: UIView {
    
    var verifyCode: String = ""
    
    var block1: LoginCanBlock?
    
    var block2: LoginCanBlock?
    
    var block3: LoginCanBlock?
    
    var block4: LoginCanBlock?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(css: "#2F0C00").withAlphaComponent(0.6)
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "loginbg")
        return bgImageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "quxiao"), for: .normal)
        btn.addTarget(self, action: #selector(canClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn1: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "button"), for: .normal)
        btn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "phonenum")
        return bgImageView
    }()
    
    lazy var bgImageView2: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "phiamge")
        return bgImageView
    }()
    
    lazy var bgImageView3: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "phone")
        return bgImageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "icon_del")
        rightImageView.contentMode = .center
        rightImageView.isHidden = true
        rightImageView.isUserInteractionEnabled = true
        rightImageView.frame = CGRect(x: 0, y: 0, width: 30.px(), height: 30.px())
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        rightImageView.addGestureRecognizer(tapGesture)
        return rightImageView
    }()
    
    lazy var phoneTed: UITextField = {
        let phoneTed = UITextField()
        phoneTed.delegate = self
        phoneTed.tintColor = UIColor.init(css: "#B74C1B")
        phoneTed.textColor = UIColor.init(css: "#B74C1B");
        phoneTed.font = UIFont(name: Fredoka_Bold, size: 18.px())
        let attrString = NSMutableAttributedString(string: "Enter Phone Number", attributes: [
            .foregroundColor: UIColor.init(css: "#FECD66") as Any,
            .font: UIFont(name: Fredoka_Bold, size: 16.px())!
        ])
        phoneTed.attributedPlaceholder = attrString
        phoneTed.keyboardType = .numberPad
        phoneTed.rightViewMode = .always
        phoneTed.rightView = rightImageView
        return phoneTed
    }()
    
    lazy var codeLable: UILabel = {
        let codeLable = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#943800"), textAlignment: .left)
        codeLable.text = "Verification Code"
        return codeLable
    }()
    
    lazy var codeView: MHVerifyCodeView = {
        let codeView = MHVerifyCodeView.init { [weak self] verifyCode in
            self?.verifyCode = verifyCode
//            print("verifyCode>>>>>>>\(verifyCode)")
        }
        codeView.verifyCount = 6
        codeView.spacing = 4.px()
        return codeView
    }()
    
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: .white, textAlignment: .left)
        infoLabel.text = "eg: 9123456789"
        return infoLabel
    }()
    
    lazy var btn2: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(UIColor.init(css: "#FFEABF"), for: .normal)
        btn.titleLabel?.font = UIFont(name: Fredoka_Bold, size: 15.px())
        btn.setBackgroundImage(UIImage(named: "fasong"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "fasong"), for: .disabled)
        btn.addTarget(self, action: #selector(sendClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var privacyLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 14.px())!, textColor: UIColor.init(css: "#943800"), textAlignment: .left)
        label.text = "Sign-in form agreeing to"
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPrivacy))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var privacyLabel1: FFShadowLabel = {
        let label = FFShadowLabel()
        label.text = " Privacy Policy."
        label.font = UIFont(name: Fredoka_Bold, size: 14.px())
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPrivacy))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(btn)
        bgImageView.addSubview(btn1)
        bgImageView.addSubview(bgImageView3)
        bgImageView.addSubview(bgImageView1)
        bgImageView.addSubview(bgImageView2)
        bgImageView3.addSubview(phoneTed)
        bgImageView.addSubview(infoLabel)
        bgImageView.addSubview(codeLable)
        bgImageView.addSubview(codeView)
        bgImageView.addSubview(btn2)
        bgImageView.addSubview(privacyLabel)
        bgImageView.addSubview(privacyLabel1)
        bgImageView.addSubview(infoLabel)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        bgImageView.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(SCREEN_WIDTH)
            make.bottom.equalTo(bgView).offset(-140.px())
            make.size.equalTo(CGSizeMake(338.px(), 389.px()))
        }
        btn.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.top).offset(6.px())
            make.right.equalTo(bgImageView.snp.right).offset(-11.px())
            make.size.equalTo(CGSizeMake(33.px(), 35.px()))
        }
        btn1.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.bottom.equalTo(bgImageView)
            make.size.equalTo(CGSizeMake(134.px(), 61.px()))
        }
        bgImageView3.snp.makeConstraints { make in
            make.top.equalTo(bgImageView).offset(111.px())
            make.left.equalTo(bgImageView).offset(33.px())
            make.size.equalTo(CGSizeMake(244.px(), 54.px()))
        }
        bgImageView1.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(129.px(), 23.px()))
            make.top.equalTo(bgImageView3.snp.top).offset(-13.px())
            make.left.equalTo(bgImageView3.snp.left).offset(-12.px())
        }
        bgImageView2.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(75.px(), 23.px()))
            make.top.equalTo(bgImageView3.snp.top).offset(-13.px())
            make.left.equalTo(bgImageView1.snp.right).offset(12.px())
        }
        phoneTed.snp.makeConstraints { make in
            make.left.equalTo(bgImageView3).offset(15.px())
            make.top.equalTo(bgImageView1.snp.bottom).offset(-4.px())
            make.bottom.equalTo(bgImageView3)
            make.right.equalTo(bgImageView3).offset(-15.px())
        }
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(bgImageView3.snp.left)
            make.top.equalTo(phoneTed.snp.bottom).offset(4.px())
            make.size.equalTo(CGSize(width: 200.px(), height: 20.px()))
        }
        codeLable.snp.makeConstraints { make in
            make.left.equalTo(bgImageView3.snp.left)
            make.top.equalTo(infoLabel.snp.bottom).offset(23.px())
            make.height.equalTo(20.px())
        }
        codeView.snp.makeConstraints { make in
            make.left.equalTo(bgImageView3.snp.left)
            make.top.equalTo(codeLable.snp.bottom).offset(10.px())
            make.height.equalTo(39.px())
            make.right.equalTo(bgImageView3.snp.right)
        }
        btn2.snp.makeConstraints { make in
            make.centerY.equalTo(codeView.snp.centerY)
            make.left.equalTo(codeView.snp.right).offset(10.px())
            make.size.equalTo(CGSizeMake(55.px(), 26.px()))
        }
        privacyLabel.snp.makeConstraints { make in
            make.left.equalTo(codeLable.snp.left)
            make.top.equalTo(codeView.snp.bottom).offset(22.px())
            make.height.equalTo(24.px())
        }
        privacyLabel1.snp.makeConstraints { make in
            make.left.equalTo(privacyLabel.snp.right)
            make.top.equalTo(codeView.snp.bottom).offset(22.px())
            make.height.equalTo(24.px())
            make.width.equalTo(132.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: UITextFieldDelegate  {
    
    @objc func canClick() {
        self.block1?()
    }
    
    @objc func loginClick() {
        self.block2?()
    }
    
    @objc func sendClick() {
        self.block3?()
    }
    
    @objc func openPrivacy() {
        self.block4?()
    }
    
    @objc func imageTapped() {
        phoneTed.text = ""
        rightImageView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
//        print("newText>>>>>\(newText.count)")
        if textField == phoneTed {
            if newText.count == 0 {
                rightImageView.isHidden = true
            }else {
                rightImageView.isHidden = false
            }
            return newText.count <= 16
        }else{
            return newText.count <= 6
        }
    }
    
}
