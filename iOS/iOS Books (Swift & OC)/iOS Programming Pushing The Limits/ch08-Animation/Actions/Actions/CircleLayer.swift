//
//  CircleLayer.swift
//  Actions
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {
    var radius:CGFloat = 20     
    override init() {
        super.init()
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        let radius = self.radius
        let rect = CGRectMake((self.bounds.size.width - radius) / 2, (self.bounds.size.height - radius) / 2, radius, radius)
        CGContextAddEllipseInRect(ctx, rect)
        CGContextFillPath(ctx)
    }
    
    
    override func actionForKey(event: String) -> CAAction? {
        if self.presentationLayer() != nil {
            if event == "radius" {
                let anim: CABasicAnimation = CABasicAnimation()
                anim.keyPath = "radius"
                anim.fromValue = self.presentationLayer()?.valueForKey("radius")
                return anim
            }
        }
        return super.actionForKey(event)
    }
    
    
    override class func needsDisplayForKey(key: String) -> Bool {
        return key == "radius" ? true : super.needsDisplayForKey(key)
    }
}
