//
//  RightTypeEnumView.swift
//  Tawid Loan
//
//  Created by apple on 2024/5/20.
//

import UIKit
import Lottie
import SwiftUI

class RightTypeEnumView: UIView {
    
    var typeModel: FearedModel? {
        didSet {
            guard let typeModel = typeModel else { return }
            switch typeModel.enjoyment {
            case "ua":
                currentState = .ua
                break
            case "ea":
                currentState = .ea
                break
            case "ef":
                currentState = .ef
                break
            case "ee":
                currentState = .ee
                break
            case "ww":
                currentState = .ww
                break
            case "done":
                currentState = .done
                break
            default:
                break
            }
        }
    }
    
    lazy var typeView: RightTypeSView = {
        let typeView = RightTypeSView()
        return typeView
    }()
    
    enum typeEnumProcessStatus {
        case ua
        case ea
        case ef
        case ee
        case ww
        case done
    }
    
    var currentState: typeEnumProcessStatus = .ua {
        didSet {
            currentTypeState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RightTypeEnumView {
    
    func currentTypeState() {
        typeView.nameLabel.text = typeModel?.verifyTitle
        let numRate = Float(typeModel?.verifyRate ?? "0.00") ?? 0.00
        typeView.bgImageView1.snp.updateConstraints { make in
            make.width.equalTo(91 * numRate)
        }
        if currentState == .done {
            typeView.iconImageView.animation = LottieAnimation.named("FCLoading.json")!
        }else {
            typeView.iconImageView.animation = LottieAnimation.named("ing.json")!
        }
        typeView.iconImageView.loopMode = .loop
        typeView.iconImageView.play()
    }
}
