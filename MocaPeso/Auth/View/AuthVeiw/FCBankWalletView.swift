//
//  FCBankWalletView.swift
//  FutureCash
//
//  Created by apple on 2024/5/11.
//

import UIKit

class FCBankWalletView: UIView {
    
    var block: ((UIButton) -> Void)?
    
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
        iconImageView2.image = UIImage(named: "personalImage")
        iconImageView2.isUserInteractionEnabled = true
        return iconImageView2
    }()
    
    lazy var downImageView: UIImageView = {
        let downImageView = UIImageView()
        downImageView.image = UIImage(named: "down")
        midImageView.isUserInteractionEnabled = true
        return downImageView
    }()
    
    lazy var midImageView: UIImageView = {
        let midImageView = UIImageView()
        midImageView.image = UIImage(named: "middle")
        midImageView.isUserInteractionEnabled = true
        return midImageView
    }()
    
    lazy var upImageView: UIImageView = {
        let upImageView = UIImageView()
        upImageView.image = UIImage(named: "upimage")
        upImageView.isUserInteractionEnabled = true
        return upImageView
    }()
    
    lazy var walletBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "walletsel"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var bankBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "banknosel"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = false
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView1)
        iconImageView1.addSubview(iconImageView2)
        iconImageView1.addSubview(downImageView)
        iconImageView1.addSubview(midImageView)
        iconImageView1.addSubview(upImageView)
        iconImageView1.addSubview(walletBtn)
        iconImageView1.addSubview(bankBtn)
        iconImageView1.addSubview(scrollView)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImageView1.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        
        upImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView2.snp.bottom).offset(6.px())
            make.left.right.equalTo(iconImageView1)
            make.height.equalTo(95.px())
        }
        downImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(iconImageView1)
            make.height.equalTo(95.px())
        }
        midImageView.snp.makeConstraints { make in
            make.top.equalTo(upImageView.snp.bottom)
            make.bottom.equalTo(downImageView.snp.top)
            make.left.right.equalTo(iconImageView1)
        }
        walletBtn.snp.makeConstraints { make in
            make.top.equalTo(upImageView.snp.top).offset(26.px())
            make.left.equalTo(iconImageView1).offset(28.px())
            make.size.equalTo(CGSizeMake(147.px(), 58.px()))
        }
        bankBtn.snp.makeConstraints { make in
            make.top.equalTo(upImageView.snp.top).offset(26.px())
            make.right.equalTo(iconImageView1).offset(-28.px())
            make.size.equalTo(CGSizeMake(147.px(), 58.px()))
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(walletBtn.snp.bottom).offset(20.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            iconImageView2.snp.makeConstraints { make in
                make.centerX.equalTo(bgView)
                make.size.equalTo(CGSizeMake(363.px(), 105.px()))
                make.top.equalTo(height.totalHeight + 4.px())
            }
        }
    }
}

extension FCBankWalletView {

    @objc func buttonTapped(_ sender: UIButton) {
        self.block?(sender)
    }
    
}
