//
//  FCFaceView.swift
//  FutureCash
//
//  Created by apple on 2024/5/7.
//

import UIKit

class FCFaceView: UIView {

    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var iconImageView1: UIImageView = {
        let iconImageView1 = UIImageView()
        iconImageView1.contentMode = .scaleAspectFill
        iconImageView1.clipsToBounds = true
        iconImageView1.image = UIImage(named: "bg1")
        iconImageView1.isUserInteractionEnabled = true
        return iconImageView1
    }()
    
    lazy var iconImageView2: UIImageView = {
        let iconImageView2 = UIImageView()
        iconImageView2.image = UIImage(named: "Slifaceidim")
        return iconImageView2
    }()
    
    lazy var iconImageView3: UIImageView = {
        let iconImageView3 = UIImageView()
        iconImageView3.image = UIImage(named: "q54fdafd")
        return iconImageView3
    }()
    
    lazy var iconImageView4: UIImageView = {
        let iconImageView4 = UIImageView()
        iconImageView4.image = UIImage(named: "Slicervgtgg")
        iconImageView4.layer.cornerRadius = 70.px()
        iconImageView4.clipsToBounds = true
        return iconImageView4
    }()
    
    lazy var iconImageView5: UIImageView = {
        let iconImageView5 = UIImageView()
        iconImageView5.image = UIImage(named: "Slicefcfrtf")
        return iconImageView5
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 15.px())!, textColor: UIColor.init(css: "#B74C1B"), textAlignment: .center)
        nameLabel.numberOfLines = 0
        nameLabel.text = "Please ensure good lighting, avoid obstructions, maintain a natural expression, and stay relatively still.*"
        return nameLabel
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.isHidden = false
        changeBtn.setImage(UIImage(named: "beaginbbb"), for: .normal)
        changeBtn.addTarget(self, action: #selector(changeBtnClick), for: .touchUpInside)
        return changeBtn
    }()
    
    lazy var changeBtn1: UIButton = {
        let changeBtn1 = UIButton(type: .custom)
        changeBtn1.isHidden = true
        changeBtn1.setImage(UIImage(named: "nexticon"), for: .normal)
        changeBtn1.addTarget(self, action: #selector(changeBtnClick1), for: .touchUpInside)
        return changeBtn1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(scrollView)
        scrollView.addSubview(iconImageView2)
        scrollView.addSubview(iconImageView3)
        iconImageView3.addSubview(iconImageView4)
        iconImageView3.addSubview(iconImageView5)
        iconImageView3.addSubview(nameLabel)
        scrollView.addSubview(changeBtn)
        scrollView.addSubview(changeBtn1)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView2.snp.bottom).offset(40.px())
            make.size.equalTo(CGSizeMake(333.px(), 360.px()))
        }
        iconImageView4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView3).offset(40.px())
            make.size.equalTo(CGSizeMake(140.px(), 140.px()))
        }
        iconImageView5.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView4.snp.bottom).offset(13.px())
            make.size.equalTo(CGSizeMake(255.px(), 72.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView5.snp.bottom).offset(13.px())
            make.left.equalTo(iconImageView3.snp.left).offset(37.5.px())
        }
        changeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
            make.top.equalTo(iconImageView3.snp.bottom).offset(31.5.px())
        }
        changeBtn1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSizeMake(183.px(), 86.px()))
            make.top.equalTo(iconImageView3.snp.bottom).offset(31.5.px())
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalTo(bgView)
                make.size.equalTo(CGSizeMake(363.px(), 105.px()))
                make.top.equalTo(height.navigationBarHeight + 4.px())
            }
        }
        changeBtn.setNeedsLayout()
        self.layoutIfNeeded()
        let maxY = CGRectGetMaxY(changeBtn.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCFaceView {
    
    @objc func changeBtnClick() {
        self.block?()
    }
    
    @objc func changeBtnClick1() {
        self.block1?()
    }
    
}


