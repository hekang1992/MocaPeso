//
//  FCHUD.swift
//  FutureCash
//
//  Created by apple on 2024/4/12.
//

import Foundation
import MBProgressHUD

@objc public enum FCHUDPostion: Int {
    case top, center, bottom
}

public extension MBProgressHUD {
    
    @objc class func show(text: String) {
        DispatchQueue.main.async {
            show(text: text, postion: .center, to: UIApplication.shared.delegate!.window!)
        }
    }
    
    @objc class func show(text: String, postion: FCHUDPostion, to view: UIView?) {
        let hud = MBProgressHUD.showAdded(to: (view ?? UIApplication.shared.delegate!.window!)!, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0, alpha: 0)
        hud.bezelView.layer.masksToBounds = true
        hud.isUserInteractionEnabled = true
        hud.mode = .customView
        
        let size = CGSize(width: SCREEN_WIDTH - 68.px(), height: CGFloat(MAXFLOAT))
        let font = UIFont(name: Fredoka_Bold, size: 22.px())
        let rect = text.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], attributes: [.font: font!] , context:nil)
        hud.minSize = CGSize(width: rect.width + 36.px(), height: rect.height > 60.px() ? rect.height + 20.px() : 60.px())
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width + 36.px(), height: rect.height > 60.px() ? rect.height + 20.px() : 60.px()))
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        textLabel.font = font
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = UIColor.init(css: "#FFFFFF")
        textLabel.alpha = 0.8
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 10.px()
        hud.bezelView.addSubview(textLabel)
        hud.margin = 20.px()
        hud.setPostion(postion)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    private func setPostion(_ postion: FCHUDPostion) {
        switch postion {
        case .top: offset = CGPoint(x: 0, y: -MBProgressMaxOffset)
        case .center: offset = .zero
        case .bottom: offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        }
    }
}

