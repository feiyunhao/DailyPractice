//
//  HypnosisterView.swift
//  Hypnosister
//
//  Created by feiyun on 16/7/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class HypnosisterView: UIView {

    override func awakeFromNib() {
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let rect = self.bounds
        let center = CGPointMake(rect.origin.x + rect.size.width / 2,
                                 rect.origin.y + rect.size.height / 2)
        
        let maxRadius = hypot(center.x, center.y)/2
        let bezierPath = UIBezierPath()
        
        for i in 0...Int(maxRadius/20) {
            let currentRadius = CGFloat(maxRadius - 20.0 * CGFloat(i))
            bezierPath.moveToPoint(CGPointMake(center.x + currentRadius, center.y))
            bezierPath.addArcWithCenter(center, radius: currentRadius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        }
        
        bezierPath.lineWidth = 10
        UIColor.lightGrayColor().setStroke()        
        bezierPath.stroke()
        
        let logoImage = UIImage(named: "logo")
        logoImage?.drawInRect(CGRectInset(self.bounds, 50, 100))
        
        
        let contextRef = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(contextRef, 1, 0, 0, 1)
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 100)
        CGPathAddLineToPoint(path, nil, 300, 100)
        CGContextAddPath(contextRef, path)
        CGContextStrokePath(contextRef)
        
        UIColor.blueColor().setStroke()
        let path2 = UIBezierPath()
        path2.moveToPoint(CGPointMake(0, 105))
        path2.addLineToPoint(CGPointMake(300, 105))
        path2.stroke()
        
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.redColor(),UIColor.yellowColor(),UIColor.blueColor()], [0.3,0.7])
        
        CGContextDrawLinearGradient(contextRef, gradient, CGPointZero, CGPointMake(1, 1), [.DrawsAfterEndLocation,.DrawsBeforeStartLocation])
        
        CGContextSaveGState(contextRef)
        CGContextRestoreGState(contextRef)
        
        
        
        
        
    }
    

}
