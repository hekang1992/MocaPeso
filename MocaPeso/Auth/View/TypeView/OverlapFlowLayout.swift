//
//  OverlapFlowLayout.swift
//  FutureCash
//
//  Created by apple on 2024/4/26.
//

import UIKit

class OverlapFlowLayout: UICollectionViewFlowLayout {
    
    var selectedIndexPath: IndexPath?
    
    let padding: CGFloat = 10.px()
    
    let columns: Int = 2
    
    var itemWidth: CGFloat = 0
    
    var itemHeight: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        let attributesCopy = attributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
        for attribute in attributesCopy {
            let row = attribute.indexPath.item / columns
            let offset: CGFloat = -35.px()
            attribute.transform = CGAffineTransform(translationX: 0, y: offset * CGFloat(row))
            attribute.zIndex = row
            if let selected = selectedIndexPath, attribute.indexPath.item % columns == selected.item % columns {
                if attribute.indexPath.item == selected.item {
                    let offsetY: CGFloat = -30.px()
                    attribute.transform = attribute.transform.scaledBy(x: 1.08, y: 1.08)
                    attribute.transform = attribute.transform.translatedBy(x: 0, y: offsetY)
                }
            }
        }
        return attributesCopy
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        scrollDirection = .vertical
        itemSize = CGSize(width: 157.px(), height: 88.px())
        minimumLineSpacing = 1.px()
        minimumInteritemSpacing = 1.px()
    }
    
}
