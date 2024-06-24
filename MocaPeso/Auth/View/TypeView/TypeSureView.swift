//
//  TypeSureView.swift
//  FutureCash
//
//  Created by apple on 2024/4/29.
//

import UIKit

class TypeSureView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?

    lazy var bgimageView: UIImageView = {
        let bgimageView = UIImageView()
        bgimageView.image = UIImage(named: "Sliceyello")
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
        label1.text = "You have selected"
        return label1
    }()
    
    lazy var label2: FFShadowLabel = {
        let label2 = FFShadowLabel()
        label2.font = UIFont(name: Fredoka_Bold, size: 20.px())
        label2.textAlignment = .center
        return label2
    }()

    lazy var label3: UILabel = {
        let label3 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#B74C1B"), textAlignment: .center)
        label3.numberOfLines = 0
        label3.text = "If the selected type does not match the uploaded one, it may lead to the failure of the loan application. Please confirm carefully."
        return label3
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "changebtn"), for: .normal)
        btn1.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "fpnfitbtn"), for: .normal)
        btn2.addTarget(self, action: #selector(btnClick2), for: .touchUpInside)
        return btn2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(bgimageView)
        bgimageView.addSubview(idImageView)
        addSubview(iconImageView)
        bgimageView.addSubview(label1)
        bgimageView.addSubview(label2)
        bgimageView.addSubview(label3)
        addSubview(btn1)
        addSubview(btn2)
        btn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(27.5.px())
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            make.top.equalTo(self).offset(145.px())
        }
        bgimageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(btn.snp.bottom).offset(6.px())
            make.size.equalTo(CGSizeMake(320.px(), 357.px()))
        }
        idImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.top.equalTo(bgimageView)
            make.size.equalTo(CGSizeMake(244.px(), 145.px()))
        }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(19.5.px(), 45.5.px()))
            make.top.equalTo(idImageView.snp.top).offset(-14.5.px())
            make.right.equalTo(idImageView.snp.right).offset(-41.px())
        }
        label1.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.size.equalTo(CGSizeMake(300.px(), 22.px()))
            make.top.equalTo(idImageView.snp.bottom).offset(28.px())
        }
        label2.snp.makeConstraints { make in
            make.centerX.equalTo(bgimageView)
            make.size.equalTo(CGSizeMake(300.px(), 22.px()))
            make.top.equalTo(label1.snp.bottom).offset(4.px())
        }
        label3.snp.makeConstraints { make in
            make.left.equalTo(bgimageView).offset(28.px())
            make.centerX.equalTo(bgimageView)
            make.top.equalTo(label2.snp.bottom).offset(13.px())
        }
        btn1.snp.makeConstraints { make in
            make.top.equalTo(bgimageView.snp.bottom).offset(15.px())
            make.left.equalTo(self).offset(10.px())
            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
        }
        btn2.snp.makeConstraints { make in
            make.top.equalTo(bgimageView.snp.bottom).offset(15.px())
            make.right.equalTo(self).offset(-10.px())
            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TypeSureView {
    
    @objc func btnClick() {
        self.block?()
    }
    
    @objc func btnClick1() {
        self.block1?()
    }
    
    @objc func btnClick2() {
        self.block2?()
    }
    
}
