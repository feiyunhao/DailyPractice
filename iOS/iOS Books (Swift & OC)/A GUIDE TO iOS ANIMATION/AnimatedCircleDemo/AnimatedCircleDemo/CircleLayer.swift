//
//  CircleLayer.swift
//  AnimatedCircleDemo
//
//  Created by feiyun on 16/8/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

enum MovingPoint {
    case POINT_D
    case POINT_B
}

let outsideRectSize: CGFloat = 90

class CircleLayer: CALayer {
    
    var progress: CGFloat = 0.0 {
        didSet {
            if progress <= 0.5 {
                movePoint = .POINT_B
            } else {
               movePoint = .POINT_D
            }
            self.lastProgress = progress
            let buff = (progress - 0.5)*(frame.size.width - outsideRectSize)
            let origin_x = position.x - outsideRectSize/2 + buff
            let origin_y = position.y - outsideRectSize/2
            outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize)
            setNeedsDisplay()
        }
    }
    
    private var outsideRect: CGRect!
    private var lastProgress: CGFloat = 0.5
    private var movePoint: MovingPoint!
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? CircleLayer {
            progress = layer.progress
            outsideRect = layer.outsideRect
            lastProgress = layer.lastProgress
        }
    }
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let offset = outsideRect.size.width / 3.6
        let movedDistance = (self.outsideRect.size.width * 1 / 6) * fabs(self.progress - 0.5) * 2
        let rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width/2 , self.outsideRect.origin.y + self.outsideRect.size.height/2)
        
        let pointA = CGPointMake(rectCenter.x, outsideRect.origin.y + movedDistance)
        let pointB = CGPointMake(movePoint == .POINT_D ? rectCenter.x + outsideRect.size.width / 2 : rectCenter.x + outsideRect.size.width / 2 + movedDistance * 2, rectCenter.y)
        let pointC = CGPointMake(rectCenter.x, rectCenter.y + outsideRect.size.width / 2 - movedDistance)
        let pointD = CGPointMake(movePoint == .POINT_B ? outsideRect.origin.x : outsideRect.origin.x - movedDistance * 2, rectCenter.y)
        
        let c1 = CGPointMake(pointA.x + offset, pointA.y)
        let c2 = CGPointMake(pointB.x, movePoint == .POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance)
        
        let c3 = CGPointMake(pointB.x, movePoint == .POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance)
        let c4 = CGPointMake(pointC.x + offset, pointC.y)
        
        let c5 = CGPointMake(pointC.x - offset, pointC.y)
        let c6 = CGPointMake(pointD.x, movePoint == .POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset)
        
        let c7 = CGPointMake(pointD.x, movePoint == .POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset)
        let c8 = CGPointMake(pointA.x - offset, pointA.y)
        
        
        let rectPath = UIBezierPath(rect: outsideRect)
        CGContextAddPath(ctx, rectPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 1)
        let dash:[CGFloat] = [5, 5]
        CGContextSetLineDash(ctx, 0, dash, 2)
        CGContextStrokePath(ctx)
        
        
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(pointA)
        ovalPath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        ovalPath.closePath()
        
        CGContextAddPath(ctx, ovalPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineDash(ctx, 0, nil, 0)
        CGContextDrawPath(ctx, .FillStroke)
        
        
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.yellowColor().CGColor)
        let points = [NSValue(CGPoint: pointA), NSValue(CGPoint: pointB), NSValue(CGPoint: pointC), NSValue(CGPoint: pointD), NSValue(CGPoint: c1), NSValue(CGPoint: c2), NSValue(CGPoint: c3), NSValue(CGPoint: c4), NSValue(CGPoint: c5), NSValue(CGPoint: c6), NSValue(CGPoint: c7), NSValue(CGPoint: c8)]
        drawPoint(points, ctx: ctx)
        
        
        let helperline = UIBezierPath()
        helperline.moveToPoint(pointA)
        helperline.addLineToPoint(c1)
        helperline.addLineToPoint(c2)
        helperline.addLineToPoint(pointB)
        helperline.addLineToPoint(c3)
        helperline.addLineToPoint(c4)
        helperline.addLineToPoint(pointC)
        helperline.addLineToPoint(c5)
        helperline.addLineToPoint(c6)
        helperline.addLineToPoint(pointD)
        helperline.addLineToPoint(c7)
        helperline.addLineToPoint(c8)
        helperline.closePath()
        
        CGContextAddPath(ctx, helperline.CGPath)
        let dash2 = [CGFloat(2.0), CGFloat(2.0)]
        CGContextSetLineDash(ctx, 0.0, dash2, 2);
        CGContextStrokePath(ctx)
        
    }
    
    
    private func drawPoint(points: [NSValue], ctx: CGContextRef) {
        for pointValue in points {
            let point = pointValue.CGPointValue()
            CGContextFillRect(ctx, CGRectMake(point.x - 2,point.y - 2,4,4))
        }
    }

}
