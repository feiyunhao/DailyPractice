//
//  DraggableView.swift
//  TearOff
//
//  Created by feiyun on 16/7/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DraggableView: UIView, NSCopying {

    var snapBehavior: UISnapBehavior?
    var dynamicAnimator: UIDynamicAnimator
    var gestureRecognizer: UIGestureRecognizer!
    
    init(frame: CGRect, animator: UIDynamicAnimator) {
        dynamicAnimator = animator;
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGrayColor()
        self.layer.borderWidth = 2;
        gestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func handlePan(g: UIPanGestureRecognizer) {
        if g.state == .Ended || g.state == .Cancelled {
            self.stopDragging()
        } else {
            self.dropToPoint(g.locationInView(self.superview))
        }
    }
    
    func dropToPoint(point: CGPoint) {
        if let behavior = snapBehavior {
            dynamicAnimator.removeBehavior(behavior)
        }
        snapBehavior = UISnapBehavior.init(item: self, snapToPoint: point)
        print(point)
        snapBehavior?.damping = 0.25
        dynamicAnimator.addBehavior(snapBehavior!)
    }
    
    
    func stopDragging() {
        if let behavior = snapBehavior {
            dynamicAnimator.removeBehavior(behavior)
        }
        snapBehavior = nil
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let newView = DraggableView.init(frame: CGRectZero, animator: self.dynamicAnimator)
        newView.bounds = self.bounds
        newView.center = self.center
        newView.transform = self.transform
        newView.alpha = self.alpha
//        (newView.layer as! CATextLayer).string = String(num)
        num += 1
        return newView
    }
    
    override class func layerClass() -> AnyClass {
        return CATextLayer.self
    }
}

var num = 1;