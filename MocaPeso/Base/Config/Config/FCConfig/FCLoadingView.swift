//
//  FCLoadingView.swift
//  FutureCash
//
//  Created by apple on 2024/4/12.
//

import UIKit
import Foundation
import Lottie

class LoadView: UIView {
    
    lazy var grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25.px()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    lazy var hudView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "FCLoading.json", bundle: Bundle.main)
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(grayView)
        grayView.addSubview(hudView)
        setConstraints()
    }
    
    private func setConstraints() {
        grayView.snp.makeConstraints { make in
//            make.center.equalTo(self)
//            make.size.equalTo(CGSizeMake(140.px(), 100.px()))
            make.edges.equalToSuperview()
        }
        hudView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 140.px(), height: 100.px()))
        }
    }
}

class ViewHud {
    static let loadView = LoadView()
    static func createLoadView() -> LoadView {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                }
            }
        }
        return loadView
    }
    static func hideLoadView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            loadView.removeFromSuperview()
        }
    }
}
