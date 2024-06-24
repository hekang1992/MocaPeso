//
//  FCLogOutView.swift
//  FutureCash
//
//  Created by apple on 2024/4/25.
//

import UIKit

class FCLogOutView: UIView {
    
    var block:(() -> Void)?
    var block1:(() -> Void)?

    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.isUserInteractionEnabled = true
        iconImageView.image = UIImage(named: "POPout")
        return iconImageView
    }()
    
    lazy var conBtn: UIButton = {
        let conBtn = UIButton(type: .custom)
        conBtn.setImage(UIImage(named: "quxiao"), for: .normal)
        conBtn.addTarget(self, action: #selector(conClick), for: .touchUpInside)
        return conBtn
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setImage(UIImage(named: "confirBtn"), for: .normal)
        confirmBtn.addTarget(self, action: #selector(confirBtnClick), for: .touchUpInside)
        return confirmBtn
    }()
    
    lazy var titleLable: FFShadowLabel = {
        let titleLable = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable.font = UIFont(name: Fredoka_Bold, size: 18.px())
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 0
        titleLable.text = "Logging out will prevent you from viewing bills and application progress.\nSimply log back in to view them."
        return titleLable
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(confirmBtn)
        iconImageView.addSubview(conBtn)
        iconImageView.addSubview(titleLable)
        setUpLogOutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FCLogOutView {
    
    func setUpLogOutView() {
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSizeMake(300.px(), 245.px()))
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(iconImageView.snp.bottom).offset(25.5.px())
            make.size.equalTo(CGSizeMake(186.px(), 61.px()))
        }
        
        conBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(31.px(), 33.px()))
            make.top.equalTo(iconImageView).offset(20.px())
            make.left.equalTo(iconImageView).offset(20.px())
        }
        
        titleLable.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView)
            make.left.equalTo(iconImageView).offset(20.px())
            make.top.equalTo(iconImageView).offset(78.5.px())
        }
    }
    
    @objc func confirBtnClick() {
        self.block?()
    }
    
    @objc func conClick() {
        self.block1?()
    }
    
}


