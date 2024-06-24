//
//  RightTwoView.swift
//  FutureCash
//
//  Created by apple on 2024/5/14.
//

import UIKit

class RightTwoView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.addTarget(self, action: #selector(btn1Click), for: .touchUpInside)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.addTarget(self, action: #selector(btn2Click), for: .touchUpInside)
        return btn2
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var hongqi: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "honeqibg")
        return bgImageView
    }()
    
    lazy var heiqi: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "heiqiimage")
        return bgImageView
    }()
    
    lazy var bgIcon1: UIImageView = {
        let bgIcon1 = UIImageView()
        bgIcon1.image = UIImage(named: "boutImageaaa")
        return bgIcon1
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label1.text = "Loan provider"
        return label1
    }()
    
    lazy var label2: UILabel = {
        let label2 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label2.text = "TAWID LENDING CORPORATION"
        return label2
    }()
    
    lazy var label3: UILabel = {
        let label3 = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label3.text = "SEC NO."
        return label3
    }()
    
    lazy var label4: UILabel = {
        let label4 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .right)
        label4.text = "CS201825429"
        return label4
    }()
    
    lazy var label5: UILabel = {
        let label5 = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label5.text = "COA NO."
        return label5
    }()
    
    lazy var label6: UILabel = {
        let label6 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .right)
        label6.text = "2838"
        return label6
    }()
    
    lazy var label7: UILabel = {
        let label7 = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label7.text = "Address"
        return label7
    }()
    
    lazy var label8: UILabel = {
        let label8 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label8.numberOfLines = 0
        label8.text = "Tawid, Candijay, Bohol, Philippines 6312"
        return label8
    }()
    
    lazy var label9: FFShadowLabel = {
        let label9 = FFShadowLabel()
        label9.font = UIFont(name: Fredoka_Bold, size: 16.px())
        label9.textAlignment = .center
        label9.text = "Website"
        return label9
    }()
    
    lazy var label10: UILabel = {
        let label10 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        label10.text = "\(BASE_H5_URL)"
        return label10
    }()
    
    lazy var iconWeb: UIImageView = {
        let iconWeb = UIImageView()
        iconWeb.image = UIImage(named: "Slicesuosfa")
        return iconWeb
    }()
    
    lazy var bgIcon2: UIImageView = {
        let bgIcon2 = UIImageView()
        bgIcon2.image = UIImage(named: "boutImageaaa")
        return bgIcon2
    }()
    
    lazy var bgIcon3: UIImageView = {
        let bgIcon3 = UIImageView()
        bgIcon3.image = UIImage(named: "boutImageaaa")
        return bgIcon3
    }()
    
    lazy var bgIcon4: UIImageView = {
        let bgIcon4 = UIImageView()
        bgIcon4.isUserInteractionEnabled = true
        bgIcon4.image = UIImage(named: "f4trvfda")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        bgIcon4.addGestureRecognizer(tapGesture)
        return bgIcon4
    }()
    
    lazy var typeView: RightTypeEnumView = {
        let typeView = RightTypeEnumView()
        return typeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(scrollView)
        scrollView.addSubview(hongqi)
        scrollView.addSubview(heiqi)
        heiqi.addSubview(btn1)
        heiqi.addSubview(btn2)
        scrollView.addSubview(bgIcon1)
        bgIcon1.addSubview(label1)
        bgIcon1.addSubview(label2)
        scrollView.addSubview(bgIcon2)
        bgIcon2.addSubview(label3)
        bgIcon2.addSubview(label4)
        bgIcon2.addSubview(label5)
        bgIcon2.addSubview(label6)
        scrollView.addSubview(bgIcon3)
        bgIcon3.addSubview(label7)
        bgIcon3.addSubview(label8)
        scrollView.addSubview(bgIcon4)
        bgIcon4.addSubview(label9)
        bgIcon4.addSubview(iconWeb)
        bgIcon4.addSubview(label10)
        hongqi.addSubview(typeView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 4.px(), right: 0))
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hongqi.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSizeMake(140.px(), 224.px()))
        }
        heiqi.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(hongqi.snp.right)
            make.size.equalTo(CGSizeMake(140.px(), 224.px()))
        }
        bgIcon1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hongqi.snp.bottom).offset(20.px())
            make.left.equalToSuperview().offset(15.px())
            make.height.equalTo(70.px())
        }
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.px())
            make.left.equalToSuperview().offset(17.px())
            make.height.equalTo(19.5.px())
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(5.5.px())
            make.left.equalToSuperview().offset(17.px())
            make.height.equalTo(18.px())
        }
        bgIcon2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgIcon1.snp.bottom).offset(20.px())
            make.left.equalToSuperview().offset(15.px())
            make.height.equalTo(70.px())
        }
        label3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.px())
            make.left.equalToSuperview().offset(17.px())
            make.height.equalTo(19.5.px())
        }
        label5.snp.makeConstraints { make in
            make.top.equalTo(label3.snp.bottom).offset(7.5.px())
            make.left.equalToSuperview().offset(17.px())
            make.height.equalTo(18.px())
        }
        label4.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.px())
            make.right.equalToSuperview().offset(-17.px())
            make.height.equalTo(19.5.px())
        }
        label6.snp.makeConstraints { make in
            make.top.equalTo(label3.snp.bottom).offset(7.5.px())
            make.right.equalToSuperview().offset(-17.px())
            make.height.equalTo(18.px())
        }
        bgIcon3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgIcon2.snp.bottom).offset(20.px())
            make.left.equalToSuperview().offset(15.px())
            make.height.equalTo(100.px())
        }
        label7.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.px())
            make.left.equalToSuperview().offset(17.px())
            make.height.equalTo(19.5.px())
        }
        label8.snp.makeConstraints { make in
            make.top.equalTo(label7.snp.bottom).offset(5.5.px())
            make.left.equalToSuperview().offset(17.px())
            make.right.equalToSuperview().offset(-17.px())
        }
        bgIcon4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgIcon3.snp.bottom).offset(20.px())
            make.left.equalToSuperview().offset(15.px())
            make.height.equalTo(70.px())
        }
        label9.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12.px())
            make.width.equalTo(62.px())
            make.height.equalTo(20.px())
        }
        iconWeb.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(19.px(), 19.px()))
            make.left.equalTo(label9.snp.right).offset(5.px())
            make.top.equalToSuperview().offset(12.px())
        }
        label10.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconWeb.snp.bottom).offset(5.5.px())
            make.height.equalTo(18.px())
        }
        btn1.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(113.px())
        }
        btn2.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(113.px())
        }
        typeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgIcon4.setNeedsLayout()
        self.layoutIfNeeded()
        let maxY = CGRectGetMaxY(bgIcon4.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var typeModel: FearedModel? {
        didSet {
            guard let typeModel = typeModel else { return }
            typeView.typeModel = typeModel
        }
    }
    
}

extension RightTwoView {
    
    @objc func btn1Click() {
        self.block1?()
    }
    
    @objc func btn2Click() {
        self.block2?()
    }
    
    @objc func imageTapped() {
        self.block3?()
    }
}
