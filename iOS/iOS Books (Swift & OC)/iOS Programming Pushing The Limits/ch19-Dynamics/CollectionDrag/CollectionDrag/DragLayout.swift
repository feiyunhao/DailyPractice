//
//  DragLayout.swift
//  CollectionDrag
//
//  Created by feiyun on 16/7/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DragLayout: UICollectionViewFlowLayout {

    var indexPath: NSIndexPath!
    var animator: UIDynamicAnimator?
    var behavior: UIAttachmentBehavior!
    
    func startDraggingIndexPath(indexPath: NSIndexPath, fromPoint p: CGPoint) -> Void {
        self.indexPath = indexPath
        self.animator = UIDynamicAnimator.init(collectionViewLayout: self)
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)!
        attributes.zIndex += 1
        self.behavior = UIAttachmentBehavior.init(item: attributes, attachedToAnchor: p)
        self.behavior.length = 0
        self.behavior.frequency = 5
        self.animator!.addBehavior(behavior)
        
        let dynamicItem = UIDynamicItemBehavior.init(items: [attributes])
        dynamicItem.resistance = 10
        self.animator?.addBehavior(dynamicItem)
        
        self.updateDragLocation(p)
    }
    
    func updateDragLocation(p: CGPoint) -> Void {
        self.behavior.anchorPoint = p
    }
    
    func stopDragging() {
         let attributes = super.layoutAttributesForItemAtIndexPath(self.indexPath)!
        self.updateDragLocation(attributes.center)
        self.indexPath = nil
        self.behavior = nil
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let existingAttributes = super.layoutAttributesForElementsInRect(rect)
        var allAttributes = Array<UICollectionViewLayoutAttributes>()
        for a in existingAttributes! {
            if a.indexPath != self.indexPath {
                allAttributes.append(a)
            }
        }
        if let c = self.animator?.itemsInRect(rect) {
            allAttributes = allAttributes + (c as! [UICollectionViewLayoutAttributes])
        }
        return allAttributes
    }
}
