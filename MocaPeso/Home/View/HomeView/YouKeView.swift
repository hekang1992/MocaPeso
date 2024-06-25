//
//  YouKeView.swift
//  MocaPeso
//
//  Created by apple on 2024/6/24.
//

import UIKit
import DeviceKit

class YouKeView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    lazy var bgimageView: UIImageView = {
        let bgimageView = UIImageView()
        bgimageView.isUserInteractionEnabled = true
        bgimageView.image = UIImage(named: "yellowbgimage")
        return bgimageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "quxiao"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var idImageView: UIImageView = {
        let idImageView = UIImageView()
        idImageView.image = UIImage(named: "AppIcon")
        return idImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "huixingzhen")
        return iconImageView
    }()
    
    lazy var label1: FFShadowLabel = {
        let label1 = FFShadowLabel()
        label1.font = UIFont(name: Fredoka_Bold, size: 20.px())
        label1.textAlignment = .center
        return label1
    }()
    
//    lazy var btn1: UIButton = {
//        let btn1 = UIButton(type: .custom)
//        btn1.setImage(UIImage(named: "fpnfitbtn"), for: .normal)
//        btn1.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
//        return btn1
//    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.titleLabel?.font = UIFont(name: Fredoka_Bold, size: 20.px())
        btn2.setTitle("Visitor status access", for: .normal)
        btn2.setTitleColor(UIColor.init(css: "#8A8DA5"), for: .normal)
        btn2.addTarget(self, action: #selector(btnClick2), for: .touchUpInside)
        btn2.backgroundColor = UIColor.init(css: "#384067")
        btn2.layer.cornerRadius = 7.px()
        return btn2
    }()
    
    lazy var btn3: UIButton = {
        let btn3 = UIButton(type: .custom)
        btn3.titleLabel?.font = UIFont(name: Fredoka_Bold, size: 20.px())
        btn3.setTitle("Login", for: .normal)
        btn3.setTitleColor(UIColor.init(css: "#FFFFFF"), for: .normal)
        btn3.addTarget(self, action: #selector(btnClick3), for: .touchUpInside)
        btn3.backgroundColor = UIColor.init(css: "#384067")
        btn3.layer.cornerRadius = 7.px()
        return btn3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(bgimageView)
        bgimageView.addSubview(idImageView)
        addSubview(iconImageView)
        bgimageView.addSubview(label1)
//        addSubview(btn1)
        bgimageView.addSubview(btn2)
        bgimageView.addSubview(btn3)
        btn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(27.5.px())
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            if Device.current.isPad {
                make.top.equalToSuperview().offset(61.px())
            }else {
                make.top.equalToSuperview().offset(141.px())
            }
        }
        bgimageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(btn.snp.bottom).offset(6.px())
            make.size.equalTo(CGSizeMake(320.px(), 357.px()))
        }
        idImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.top.equalTo(bgimageView)
            make.size.equalTo(CGSizeMake(140.px(), 100.px()))
        }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(19.5.px(), 45.5.px()))
            make.top.equalTo(idImageView.snp.top).offset(-14.5.px())
            make.right.equalTo(idImageView.snp.right).offset(-41.px())
        }
        label1.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.size.equalTo(CGSizeMake(300.px(), 24.px()))
            make.top.equalTo(idImageView.snp.bottom).offset(24.px())
        }
//        btn1.snp.makeConstraints { make in
//            make.top.equalTo(bgimageView.snp.bottom).offset(15.px())
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
//        }
        btn2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(20.px())
            make.size.equalTo(CGSizeMake(235.px(), 60.px()))
        }
        btn3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn2.snp.bottom).offset(20.px())
            make.size.equalTo(CGSizeMake(235.px(), 60.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YouKeView {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func btnClick1() {
        self.block1?()
    }
    
    @objc func btnClick2() {
        self.block2?()
    }
    
    @objc func btnClick3() {
        self.block3?()
    }
}
