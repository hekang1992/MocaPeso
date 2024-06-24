//
//  FCPullHeader.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/22.
//

import UIKit
import MJRefresh
import Lottie

class FCPullHeader: MJRefreshHeader {

    lazy var headTapView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "FCLoading.json", bundle: Bundle.main)
        animationView.animationSpeed = 2
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: Fredoka_Bold, size: 15.px())!, textColor: UIColor.init(css: "#943800"), textAlignment: .center)
        nameLabel.text = "Loading..."
        return nameLabel
    }()

    override func prepare() {
        super.prepare()
        addSubview(headTapView)
        addSubview(nameLabel)
        self.mj_h = 104.px()
    }

    override func placeSubviews() {
        super.placeSubviews()
        headTapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 97.px(), height: 70.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headTapView.snp.bottom)
            make.size.equalTo(CGSize(width: 250.px(), height: 16.px()))
        }
    }
}
