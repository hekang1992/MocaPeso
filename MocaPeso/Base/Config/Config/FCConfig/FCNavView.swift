//
//  FCNavView.swift
//  FutureCash
//
//  Created by apple on 2024/4/24.
//

import UIKit

class FCNavView: UIView {

    var block: (() -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "bacnImage"), for: .normal)
        backBtn.addTarget(self, action: #selector(bankClick), for: .touchUpInside)
        return backBtn
    }()

    lazy var titleLable: FFShadowLabel = {
        let titleLable = FFShadowLabel(strockColor: UIColor.init(css: "#384067"))
        titleLable.text = ""
        titleLable.font = UIFont(name: Fredoka_Bold, size: 18.px())
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(titleLable)
        setUpFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FCNavView {
    
    func setUpFrame() {
        backBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-8.px())
            make.left.equalTo(self).offset(30.px())
            make.size.equalTo(CGSizeMake(22.px(), 28.px()))
        }
        titleLable.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(backBtn.snp.top)
            make.bottom.equalTo(backBtn.snp.bottom)
            make.width.equalTo(200.px())
        }
    }
    
    @objc func bankClick() {
        self.block?()
    }
    
}
