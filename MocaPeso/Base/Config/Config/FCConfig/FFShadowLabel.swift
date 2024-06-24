//
//  FFShadowLabel.swift
//  AnimationDemo
//
//  Created by apple on 2024/1/30.
//

import UIKit

class FFShadowLabel: UILabel {
    
    let strockWidth: CGFloat
    var fillColor: UIColor
    let stColor: UIColor
    let inset: UIEdgeInsets
    init(frame: CGRect = .zero,
         strockWidth: CGFloat = 4.0.px(),
         fillColor: UIColor = .white,
         strockColor: UIColor = UIColor.init(css: "#6B291D"),
         inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.strockWidth = strockWidth
        self.fillColor = fillColor
        self.stColor = strockColor
        self.inset = inset
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(strockWidth)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        self.textColor = stColor
        super.drawText(in: rect.inset(by: inset))
        self.textColor = fillColor
        context?.setTextDrawingMode(.fill)
        super.drawText(in: rect)
    }
}
