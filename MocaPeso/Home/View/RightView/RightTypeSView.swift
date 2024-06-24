//
//  RightTypeSView.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/20.
//

import UIKit
import Lottie

class RightTypeSView: UIView {
    
    lazy var iconImageView: LottieAnimationView = {
        let iconImageView = LottieAnimationView(name: "", bundle: Bundle.main)
        return iconImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 15.px())!, textColor: .white, textAlignment: .center)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Slicereqrev")
        return bgImageView
    }()
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView1 = UIImageView()
        bgImageView1.image = UIImage(named: "greenvimage")
        return bgImageView1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(bgImageView)
        bgImageView.addSubview(bgImageView1)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12.px())
            make.left.equalToSuperview()
            make.height.equalTo(100.px())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10.px())
            make.top.equalTo(iconImageView.snp.bottom).offset(10.px())
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(93.px())
            make.top.equalTo(nameLabel.snp.bottom).offset(7.px())
            make.height.equalTo(18.px())
        }
        bgImageView1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(2.px())
            make.top.equalToSuperview().offset(1.5.px())
            make.bottom.equalToSuperview().offset(-5.px())
            make.width.equalTo(91.px())
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
