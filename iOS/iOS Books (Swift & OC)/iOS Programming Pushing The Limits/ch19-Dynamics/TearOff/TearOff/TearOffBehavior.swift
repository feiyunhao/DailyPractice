//
//  TearOffBehavior.swift
//  TearOff
//
//  Created by feiyun on 16/7/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class TearOffBehavior: UIDynamicBehavior {
    
    var active = true
    typealias handlerType = (tornView: DraggableView, newPinView: DraggableView) -> Void
    
    init(draggableView view: DraggableView, anchor: CGPoint, handler: handlerType) {
        super.init()
        self.addChildBehavior(UISnapBehavior.init(item: view, snapToPoint: anchor))
        let distance = min(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))
        self.action = {
//            [unowned self] in
            //如果超出范围
            if !self.pointsAreWithinDistance(view.center, p2: anchor, distance: distance) {
                if self.active {//
                    let newView = view.copy()
                    view.superview?.addSubview(newView as! UIView)
                    let newTearOff = TearOffBehavior.init(draggableView: newView as! DraggableView, anchor: anchor, handler: handler)
                    newTearOff.active = false
                    self.dynamicAnimator?.addBehavior(newTearOff)
                    handler(tornView: view,newPinView: newView as! DraggableView)
                    self.dynamicAnimator?.removeBehavior(self)
                }
            }
            else {
                self.active = true
            }
        }
    }
    
    func pointsAreWithinDistance(p1: CGPoint, p2: CGPoint, distance: CGFloat) -> Bool {
        let dx = p1.x - p2.x
        let dy = p1.y - p2.y
        let currentDistance = CGFloat(hypotf(Float(dx), Float(dy)))
        return currentDistance < distance
    }
    
}
