//
//  FCHomeOneView.swift
//  FutureCash
//
//  Created by apple on 2024/5/14.
//

import UIKit

class FCHomeOneView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    var block4: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
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
        iconImageView2.image = UIImage(named: "bannerone")
        return iconImageView2
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 60.px())!, textColor: UIColor.init(css: "#FDF756"), textAlignment: .center)
        moneyLabel.text = "90,000"
        return moneyLabel
    }()
    
    lazy var iconImageView3: UIImageView = {
        let iconImageView3 = UIImageView()
        iconImageView3.image = UIImage(named: "Slicecoin")
        iconImageView3.isUserInteractionEnabled = true
        return iconImageView3
    }()
    
    lazy var iconImageView4: UIImageView = {
        let iconImageView4 = UIImageView()
        iconImageView4.image = UIImage(named: "Slicezhuanshi")
        iconImageView4.isUserInteractionEnabled = true
        return iconImageView4
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setBackgroundImage(UIImage(named: "applybrfaf"), for: .normal)
        applyBtn.addTarget(self, action: #selector(applyClick), for: .touchUpInside)
        return applyBtn
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setBackgroundImage(UIImage(named: "Sliceleft"), for: .normal)
        leftBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setBackgroundImage(UIImage(named: "Slicerightifad"), for: .normal)
        rightBtn.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy var rateView: UIView = {
        let rateView = UIView()
        rateView.layer.cornerRadius = 15.px()
        rateView.layer.borderWidth = 3.px()
        rateView.backgroundColor = UIColor.init(css: "#FFF1D6")
        rateView.layer.borderColor = UIColor.init(css: "#1B273E").cgColor
        return rateView
    }()
    
    lazy var rateLabel: FFShadowLabel = {
        let rateLabel = FFShadowLabel(strockWidth: 3.px(),
                                      fillColor: UIColor.init(css: "#65EF36") ,
                                      strockColor: UIColor.init(css: "#1B273E"))
        rateLabel.font = UIFont(name: Fredoka_Bold, size: 37.px())
        rateLabel.textAlignment = .left
        return rateLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: UIColor.init(css: "#1B273E"), textAlignment: .left)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var dayLabel: FFShadowLabel = {
        let rateLabel = FFShadowLabel(strockWidth: 3.px(),
                                      fillColor: UIColor.init(css: "#65EF36") ,
                                      strockColor: UIColor.init(css: "#1B273E"))
        rateLabel.font = UIFont(name: Fredoka_Bold, size: 37.px())
        rateLabel.textAlignment = .left
        return rateLabel
    }()
    
    lazy var dayDescLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 18.px())!, textColor: UIColor.init(css: "#1B273E"), textAlignment: .left)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var numView: UIImageView = {
        let numView = UIImageView()
        numView.image = UIImage(named: "Slicuoirn")
        return numView
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 15.px())!, textColor: .white, textAlignment: .center)
        numLabel.text = "0"
        return numLabel
    }()
    
    lazy var secBtn: UIButton = {
        let secBtn = UIButton(type: .custom)
        secBtn.setImage(UIImage(named: "SsecBtnIAMGE"), for: .normal)
        secBtn.addTarget(self, action: #selector(secBtnClick), for: .touchUpInside)
        return secBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(iconImageView2)
        iconImageView2.addSubview(moneyLabel)
        iconImageView1.addSubview(iconImageView3)
        iconImageView1.addSubview(rateView)
        rateView.addSubview(rateLabel)
        rateView.addSubview(descLabel)
        rateView.addSubview(dayLabel)
        rateView.addSubview(dayDescLabel)
        iconImageView1.addSubview(iconImageView4)
        iconImageView1.addSubview(applyBtn)
        iconImageView1.addSubview(leftBtn)
        iconImageView1.addSubview(rightBtn)
//        leftBtn.addSubview(numView)
//        numView.addSubview(numLabel)
        bgView.addSubview(secBtn)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        moneyLabel.snp.makeConstraints { make in
            make.center.equalTo(iconImageView2)
            make.size.equalTo(CGSizeMake(220.px(), 73.px()))
        }
        iconImageView3.snp.makeConstraints { make in
            make.top.equalTo(iconImageView2.snp.bottom).offset(-10.px())
            make.size.equalTo(CGSizeMake(375.px(), 437.px()))
            make.centerX.equalTo(iconImageView1)
        }
        rateView.snp.makeConstraints { make in
            make.right.equalTo(-40.px())
            make.size.equalTo(CGSizeMake(192.px(), 230.px()))
            make.top.equalTo(iconImageView2.snp.bottom).offset(40.px())
        }
        iconImageView4.snp.makeConstraints { make in
            make.right.equalTo(iconImageView1).offset(-11.px())
            make.size.equalTo(CGSizeMake(148.px(), 174.px()))
            make.top.equalTo(iconImageView3.snp.top).offset(118.px())
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView1)
            make.size.equalTo(CGSizeMake(275.px(), 100.px()))
            make.top.equalTo(iconImageView3.snp.bottom).offset(-54.px())
        }
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-10.px())
            make.size.equalTo(CGSizeMake(98.px(), 109.px()))
            make.bottom.equalToSuperview().offset(-50.px())
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(10.px())
            make.size.equalTo(CGSizeMake(98.px(), 109.px()))
            make.bottom.equalToSuperview().offset(-50.px())
        }
        rateLabel.snp.makeConstraints { make in
            make.left.equalTo(rateView).offset(10.px())
            make.top.equalTo(rateView).offset(16.px())
            make.size.equalTo(CGSizeMake(150.px(), 45.px()))
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(rateView).offset(19.px())
            make.top.equalTo(rateLabel.snp.bottom).offset(1.px())
            make.right.equalTo(rateView).offset(-60.px())
        }
        dayLabel.snp.makeConstraints { make in
            make.left.equalTo(rateView).offset(10.px())
            make.top.equalTo(descLabel.snp.bottom).offset(14.px())
            make.size.equalTo(CGSizeMake(150.px(), 45.px()))
        }
        dayDescLabel.snp.makeConstraints { make in
            make.left.equalTo(rateView).offset(19.px())
            make.top.equalTo(dayLabel.snp.bottom).offset(1.px())
            make.right.equalTo(rateView).offset(-60.px())
        }
        secBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.px())
            make.size.equalTo(CGSize(width: 66.px(), height: 66.px()))
            make.top.equalToSuperview().offset(51.px())
        }
//        numView.snp.makeConstraints { make in
//            make.top.equalTo(leftBtn)
//            make.right.equalTo(leftBtn)
//            make.size.equalTo(CGSizeMake(27.px(), 27.px()))
//        }
//        numLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalTo(bgView)
                make.size.equalTo(CGSizeMake(350.px(), 185.px()))
                make.top.equalToSuperview().offset(height.statusBarHeight + 4.px())
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ReddeningModel? {
        didSet {
            guard let model = model else { return }
            moneyLabel.text = model.spacious
            rateLabel.text = " " + (model.stories ?? "")
            descLabel.text = model.reads
            dayLabel.text = " " + (model.crime ?? "")
            dayDescLabel.text = model.enamoured
        }
    }
    
}

extension FCHomeOneView {
    
    @objc func applyClick() {
        self.block1?()
    }
    
    @objc func leftClick() {
        self.feedBack()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [], animations: {
            self.leftBtn.snp.updateConstraints { make in
                make.left.equalToSuperview()
            }
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.block2?()
            } completion: { _ in
                UIView.animate(withDuration: 0.25) {
                    self.leftBtn.snp.updateConstraints { make in
                        make.left.equalToSuperview().offset(-10.px())
                    }
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func rightClick() {
        self.feedBack()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: [], animations: {
            self.rightBtn.snp.updateConstraints { make in
                make.right.equalToSuperview()
            }
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.block3?()
            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIView.animate(withDuration: 0.25) {
                        self.rightBtn.snp.updateConstraints { make in
                            make.right.equalToSuperview().offset(10.px())
                        }
                        self.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    func feedBack() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    @objc func secBtnClick() {
        self.block4?()
    }
    
}
