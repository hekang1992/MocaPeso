//
//  FCPhotoView.swift
//  FutureCash
//
//  Created by apple on 2024/5/6.
//

import UIKit

class FCPhotoView: UIView {
    
    var nextBlock: ((() -> Void))?
    
    var albumBlock: ((() -> Void))?
    
    var cameraBlock: ((() -> Void))?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
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
        iconImageView2.image = UIImage(named: "facebgi")
        iconImageView2.isUserInteractionEnabled = true
        return iconImageView2
    }()
    
    lazy var titleLable: FFShadowLabel = {
        let titleLable = FFShadowLabel(strockColor: UIColor.init(css: "#4B520E"))
        titleLable.font = UIFont(name: Fredoka_Medium, size: 16.px())
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 0
        titleLable.text = "Please ensure that the uploaded ID card type matches the selected ID card!"
        let radians = CGFloat(tan(-2.0 * Double.pi / 180))
        titleLable.transform = CGAffineTransform(rotationAngle: radians)
        return titleLable
    }()
    
    lazy var iconImageView3: UIImageView = {//证件照片
        let iconImageView3 = UIImageView()
        iconImageView3.layer.cornerRadius = 22.px()
        iconImageView3.clipsToBounds = true
        iconImageView3.backgroundColor = UIColor.init(css: "#031F12")
        return iconImageView3
    }()
    
    lazy var iconImageView4: UIImageView = {
        let iconImageView4 = UIImageView()
        iconImageView4.isHidden = false
        iconImageView4.image = UIImage(named: "Slicephpo")
        return iconImageView4
    }()
    
    lazy var iconImageView5: UIImageView = {
        let iconImageView5 = UIImageView()
        iconImageView5.image = UIImage(named: "Slicedemo")
        return iconImageView5
    }()
    
    lazy var descLable: UILabel = {
        let descLable = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 16.px())!, textColor: UIColor.init(css: "#7EC101"), textAlignment: .center)
        descLable.text = "Ensure a clear and legible ID card photo with no missing parts."
        descLable.numberOfLines = 0
        return descLable
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.isHidden = true
        nextBtn.setImage(UIImage(named: "nexticon"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return nextBtn
    }()
    
    lazy var albumBtn: UIButton = {
        let albumBtn = UIButton(type: .custom)
        albumBtn.isHidden = true
        albumBtn.setImage(UIImage(named: "lbumicon"), for: .normal)
        albumBtn.addTarget(self, action: #selector(albumBtnClick), for: .touchUpInside)
        return albumBtn
    }()
    
    lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.isHidden = true
        cameraBtn.setImage(UIImage(named: "cameraicon"), for: .normal)
        cameraBtn.addTarget(self, action: #selector(cameraBtnClick), for: .touchUpInside)
        return cameraBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView1)
        iconImageView1.addSubview(scrollView)
        scrollView.addSubview(iconImageView2)
        iconImageView2.addSubview(titleLable)
        iconImageView2.addSubview(iconImageView3)
        iconImageView2.addSubview(iconImageView4)
        iconImageView2.addSubview(iconImageView5)
        iconImageView2.addSubview(descLable)
        scrollView.addSubview(nextBtn)
        scrollView.addSubview(albumBtn)
        scrollView.addSubview(cameraBtn)
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32.5.px())
            make.top.equalTo(iconImageView2).offset(85.px())
            make.right.equalToSuperview().offset(-50.px())
        }
        iconImageView3.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView2)
            make.size.equalTo(CGSizeMake(244.px(), 145.px()))
            make.top.equalTo(titleLable.snp.bottom).offset(48.5.px())
        }
        iconImageView4.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView2)
            make.size.equalTo(CGSizeMake(269.px(), 170.px()))
            make.top.equalTo(titleLable.snp.bottom).offset(35.5.px())
        }
        iconImageView5.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView2)
            make.size.equalTo(CGSizeMake(254.px(), 65.px()))
            make.top.equalTo(iconImageView4.snp.bottom).offset(31.px())
        }
        descLable.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView2)
            make.top.equalTo(iconImageView5.snp.bottom).offset(19.px())
            make.left.equalTo(iconImageView2).offset(50.px())
        }
        albumBtn.snp.makeConstraints { make in
            make.left.equalTo(iconImageView1).offset(10.px())
            make.size.equalTo(CGSizeMake(183.px(), 85.px()))
            make.top.equalTo(descLable.snp.bottom).offset(79.5.px())
        }
        cameraBtn.snp.makeConstraints { make in
            make.right.equalTo(iconImageView1).offset(-10.px())
            make.size.equalTo(CGSizeMake(183.px(), 85.px()))
            make.top.equalTo(descLable.snp.bottom).offset(79.5.px())
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView1)
            make.size.equalTo(CGSizeMake(183.px(), 85.px()))
            make.top.equalTo(descLable.snp.bottom).offset(79.5.px())
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalTo(iconImageView1)
                make.size.equalTo(CGSizeMake(375.px(), 599.px()))
                make.top.equalTo(height.navigationBarHeight)
            }
        }
        nextBtn.setNeedsLayout()
        self.layoutIfNeeded()
        let maxY = CGRectGetMaxY(nextBtn.frame)
        scrollView.contentSize = CGSizeMake(0, maxY + 20.px())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCPhotoView {
    
    @objc func nextBtnClick() {
        self.nextBlock?()
    }
    
    @objc func albumBtnClick() {
        self.albumBlock?()
    }
    
    @objc func cameraBtnClick() {
        self.cameraBlock?()
    }
    
}
