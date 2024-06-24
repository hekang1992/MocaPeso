//
//  SecPopView.swift
//  MocaPeso
//
//  Created by apple on 2024/6/19.
//

import UIKit
import DeviceKit

class SecPopView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.isUserInteractionEnabled = true
        iconImageView.image = UIImage(named: "home_bg_sec")
        return iconImageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "nexticon"), for: .normal)
        btn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: UIColor.init(css: "#943800"), textAlignment: .center)
        nameLabel.text = "Compliaces"
        return nameLabel
    }()
    
    lazy var secImageView: UIImageView = {
        let secImageView = UIImageView()
        secImageView.image = UIImage(named: "sec")
        return secImageView
    }()
    
    lazy var secbtn: UIButton = {
        let secbtn = UIButton(type: .custom)
        secbtn.addTarget(self, action: #selector(secbtnClick), for: .touchUpInside)
        return secbtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(btn)
        iconImageView.addSubview(nameLabel)
        iconImageView.addSubview(scrollView)
        scrollView.addSubview(secImageView)
        scrollView.addSubview(secbtn)
        iconImageView.snp.makeConstraints { make in
            if Device.current.isPad {
                make.top.equalToSuperview().offset(61.px())
            }else {
                make.top.equalToSuperview().offset(141.px())
            }
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12.px())
            make.size.equalTo(CGSize(width: 351, height: 518))
        }
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(8.px())
            make.size.equalTo(CGSize(width: 178.px(), height: 86.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30.px())
            make.left.equalToSuperview()
            make.height.equalTo(22.px())
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15.px())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(44.px())
            make.bottom.equalToSuperview().offset(-20.px())
        }
        secImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(267.px())
            make.height.equalTo(444.px())
        }
        secbtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110.px())
            make.size.equalTo(CGSize(width: 200.px(), height: 30.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.secImageView.setNeedsLayout()
        self.layoutIfNeeded()
        let maxY = CGRectGetMaxY(secImageView.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
    }
    
}

extension SecPopView {
    
    @objc func nextClick() {
        self.block?()
    }
    
    @objc func secbtnClick() {
        self.block1?()
    }
    
}

