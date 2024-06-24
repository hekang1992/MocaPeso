//
//  FCDelAccountView.swift
//  FutureCash
//
//  Created by apple on 2024/4/25.
//

import UIKit

class FCDelAccountView: UIView {
    
    var block: ((Bool) -> Void)?
    
    private var isChecked: Bool = false {
        didSet {
            checkBoxButton.isSelected = isChecked
            delBtn.isEnabled = isChecked
            priLable.fillColor = isChecked ? .white : UIColor.init(css: "#9EA9BB")
            priLable.setNeedsDisplay()
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "BGvc")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView1 = UIImageView()
        bgImageView1.image = UIImage(named: "delbgone")
        return bgImageView1
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 16.px())!, textColor: .white, textAlignment: .center)
        titleLable.text = "Delete account"
        return titleLable
    }()
    
    lazy var titleLable1: UILabel = {
        let titleLable1 = UILabel.createLabel(font: UIFont(name: Fredoka_Medium, size: 12.px())!, textColor: UIColor.init(css: "#FFE03A"), textAlignment: .center)
        titleLable1.numberOfLines = 0
        titleLable1.text = "Account termination is an irreversible action. Once terminated, the bills in your account cannot be retrieved. Please ensure that all relevant information has been handled properly before proceeding."
        return titleLable1
    }()
    
    lazy var titleLable2: UILabel = {
        let titleLable2 = UILabel.createLabel(font: UIFont(name: Fredoka_SemiBold, size: 16.px())!, textColor: .white, textAlignment: .left)
        titleLable2.numberOfLines = 0
        titleLable2.text = "Please ensure that the following requirements are met before deleting the account:"
        return titleLable2
    }()
    
    lazy var bgImageView2: UIImageView = {
        let bgImageView2 = UIImageView()
        bgImageView2.image = UIImage(named: "bgooo")
        return bgImageView2
    }()
    
    lazy var bgImageView3: UIImageView = {
        let bgImageView3 = UIImageView()
        bgImageView3.image = UIImage(named: "jinggao")
        return bgImageView3
    }()
    
    lazy var titleLable3: UILabel = {
        let titleLable3 = UILabel.createLabel(font: UIFont(name: Fredoka_SemiBold, size: 12.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        titleLable3.numberOfLines = 0
        titleLable3.text = "All bills associated with the account have been settled; there are no outstanding or disputed bills."
        return titleLable3
    }()
    
    lazy var titleLable4: UILabel = {
        let titleLable4 = UILabel.createLabel(font: UIFont(name: Fredoka_SemiBold, size: 12.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        titleLable4.numberOfLines = 0
        titleLable4.text = "The account has no outstanding unresolved disputes."
        return titleLable4
    }()
    
    lazy var titleLable5: UILabel = {
        let titleLable3 = UILabel.createLabel(font: UIFont(name: Fredoka_SemiBold, size: 12.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        titleLable3.text = "1."
        return titleLable3
    }()
    
    lazy var titleLable6: UILabel = {
        let titleLable4 = UILabel.createLabel(font: UIFont(name: Fredoka_SemiBold, size: 12.px())!, textColor: UIColor.init(css: "#384067"), textAlignment: .left)
        titleLable4.text = "2."
        return titleLable4
    }()
    
    lazy var delBtn: UIButton = {
        let delBtn = UIButton(type: .custom)
        delBtn.isEnabled = false
        delBtn.setImage(UIImage(named: "delaccountbbb"), for: .normal)
        delBtn.addTarget(self, action: #selector(delClick), for: .touchUpInside)
        return delBtn
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "bugouxuan"), for: .normal)
        button.setImage(UIImage(named: "gouxuan"), for: .selected)
        button.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        return button
    }()
    
    private let priLable: FFShadowLabel = {
        let priLable = FFShadowLabel(fillColor: UIColor.init(css: "#9EA9BB"), strockColor: UIColor.init(css: "#384067"))
        priLable.font = UIFont(name: Fredoka_Bold, size: 14.px())
        priLable.textAlignment = .left
        priLable.text = " I have read and agreed to the above notices."
        return priLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(bgImageView1)
        bgImageView.addSubview(bgImageView3)
        bgImageView1.addSubview(titleLable)
        bgImageView1.addSubview(titleLable1)
        addSubview(titleLable2)
        addSubview(bgImageView2)
        bgImageView2.addSubview(titleLable5)
        bgImageView2.addSubview(titleLable6)
        bgImageView2.addSubview(titleLable3)
        bgImageView2.addSubview(titleLable4)
        bgImageView.addSubview(delBtn)
        bgImageView.addSubview(checkBoxButton)
        bgImageView.addSubview(priLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        if let vc = self.viewController  {
            let height = UIViewController.getTopBarHeights(for: vc)
            bgImageView1.snp.makeConstraints { make in
                make.top.equalTo(bgImageView).offset(height.totalHeight + 42.px())
                make.centerX.equalTo(bgImageView)
                make.size.equalTo(CGSizeMake(315.px(), 140.px()))
            }
        }
        bgImageView3.snp.makeConstraints { make in
            make.left.equalTo(bgImageView1.snp.left).offset(-7.px())
            make.top.equalTo(bgImageView1.snp.top).offset(-9.px())
            make.size.equalTo(CGSizeMake(27.px(), 27.px()))
        }
        titleLable.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView1)
            make.top.equalTo(bgImageView1).offset(17.px())
            make.height.equalTo(20.px())
        }
        titleLable1.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView1)
            make.top.equalTo(titleLable.snp.bottom).offset(10.px())
            make.left.equalTo(bgImageView1).offset(20.px())
        }
        titleLable2.snp.makeConstraints { make in
            make.top.equalTo(bgImageView1.snp.bottom).offset(25.px())
            make.left.equalTo(bgImageView1.snp.left)
            make.centerX.equalTo(bgImageView)
        }
        bgImageView2.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.top.equalTo(titleLable2.snp.bottom).offset(15.px())
            make.size.equalTo(CGSizeMake(315.px(), 130.px()))
        }
        titleLable5.snp.makeConstraints { make in
            make.top.equalTo(bgImageView2).offset(20.px())
            make.left.equalTo(bgImageView2).offset(13.px())
            make.size.equalTo(CGSizeMake(8.px(), 14.px()))
        }
        titleLable3.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView2)
            make.left.equalTo(titleLable5.snp.right).offset(4.px())
            make.top.equalTo(bgImageView2).offset(20.px())
        }
        titleLable6.snp.makeConstraints { make in
            make.top.equalTo(titleLable3.snp.bottom).offset(15.px())
            make.left.equalTo(bgImageView2).offset(13.px())
            make.size.equalTo(CGSizeMake(8.px(), 14.px()))
        }
        titleLable4.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView2)
            make.left.equalTo(titleLable6.snp.right).offset(4.px())
            make.top.equalTo(titleLable3.snp.bottom).offset(15.px())
        }
        delBtn.snp.makeConstraints { make in
            make.centerX.equalTo(bgImageView)
            make.size.equalTo(CGSizeMake(321.px(), 61.px()))
            make.bottom.equalTo(bgImageView).offset(-55.px())
        }
        checkBoxButton.snp.makeConstraints { make in
            make.bottom.equalTo(delBtn.snp.top).offset(-25.px())
            make.left.equalTo(bgImageView).offset(35.px())
            make.size.equalTo(CGSizeMake(30.px(), 30.px()))
        }
        priLable.snp.makeConstraints { make in
            make.top.equalTo(checkBoxButton.snp.top)
            make.bottom.equalTo(checkBoxButton.snp.bottom)
            make.left.equalTo(checkBoxButton.snp.right)
            make.width.equalTo(290.px())
        }
    }
    
}

extension FCDelAccountView {
    
    @objc func delClick() {
        self.block?(isChecked)
    }
    
    @objc func toggleCheck() {
        isChecked = !isChecked
    }
}
