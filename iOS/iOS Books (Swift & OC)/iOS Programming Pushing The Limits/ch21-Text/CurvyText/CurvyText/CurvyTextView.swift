//
//  CurvyTextView.swift
//  CurvyText
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CurvyTextView: UIView {

    var layoutManager: NSLayoutManager = NSLayoutManager()
    var textStorage : NSTextStorage = NSTextStorage()
    
    var attributedString:NSMutableAttributedString? {
        set {
           self.textStorage.setAttributedString(newValue!)
        }
        get {
           return self.textStorage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addControlPoint(CGPointMake(50, 500), color: UIColor.greenColor())
        self.addControlPoint(CGPointMake(300, 300), color: UIColor.blackColor())
        self.addControlPoint(CGPointMake(400, 700), color: UIColor.blackColor())
        self.addControlPoint(CGPointMake(650, 500), color: UIColor.redColor())
        self.updateControlPoints()
        
        let textContainer = NSTextContainer()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let kControlPointSize: CGFloat = 13;
    
    func addControlPoint(point: CGPoint, color: UIColor) {
        
        let fullRect = CGRectMake(0, 0, kControlPointSize*3, kControlPointSize*3);
        let rect = CGRectInset(fullRect, kControlPointSize, kControlPointSize);
        let shapeLayer = CAShapeLayer()
        let path = CGPathCreateWithEllipseInRect(rect, nil);
        shapeLayer.path = path;
        shapeLayer.fillColor = color.CGColor;
        
        let view = UIView(frame: fullRect)
        view.layer.addSublayer(shapeLayer)
        
        let g = UIPanGestureRecognizer.init(target: self, action: #selector(pan(_:)))
        view.addGestureRecognizer(g)
        self.addSubview(view)
        view.center = point
    }
    
    func pan(g: UIPanGestureRecognizer) {
        g.view?.center = g.locationInView(self)
        self.updateControlPoints()
    }
    
    var points:[CGPoint] = Array.init(count: 4, repeatedValue: CGPointZero)
    
    func updateControlPoints()  {
        let subviews = self.subviews;
        points[0] = subviews[0].center
        points[1] = subviews[1].center
        points[2] = subviews[2].center
        points[3] = subviews[3].center
        self.setNeedsDisplay()
    }
    
        override func drawRect(rect: CGRect) {
        // Drawing code
        self.drawPath()
        self.drawText()
    }
    
    func drawPath() {
        let path = UIBezierPath()
        path.moveToPoint(points[0])
        path.addCurveToPoint(points[3], controlPoint1: points[1], controlPoint2: points[2])
        UIColor.blackColor().setStroke()
        path.stroke()
    }
    
    // MARK: - text

    func drawText() {
        if self.attributedString?.length == 0 {
            return
        }
        
        let layoutManager = self.layoutManager
        let context = UIGraphicsGetCurrentContext()
        var glyphRange = NSRange()
        let lineRect = layoutManager.lineFragmentRectForGlyphAtIndex(0, effectiveRange: &glyphRange)
        
        var offset: CGFloat = 0;
        var lastGlyphPoint = points[0]
        var lastX: CGFloat = 0;
        
        for glyphIndex in glyphRange.location..<NSMaxRange(glyphRange) {
            CGContextSaveGState(context);
            
            let location = layoutManager.locationForGlyphAtIndex(glyphIndex)
            let distance = location.x - lastX;  // Assume single line
            offset = self.offsetAtDistance(distance,
                fromPoint:lastGlyphPoint,
                andOffset:offset)
            let glyphPoint = self.pointForOffset(offset)
            let angle = self.angleForOffset(offset)
            
            lastGlyphPoint = glyphPoint;
            lastX = location.x;
            
            CGContextTranslateCTM(context, glyphPoint.x, glyphPoint.y);
            CGContextRotateCTM(context, angle);
            
            layoutManager.drawGlyphsForGlyphRange(NSMakeRange(glyphIndex, 1),
                                                  atPoint: CGPointMake(-(lineRect.origin.x + location.x),
                                                    -(lineRect.origin.y + location.y)))
             CGContextRestoreGState(context);
        }
        
    }
    
    func offsetAtDistance(aDistance: CGFloat,fromPoint aPoint:CGPoint,andOffset anOffset: CGFloat) -> CGFloat {
        let kStep:CGFloat = 0.001; // 0.0001 - 0.001 work well
        var newDistance:CGFloat = 0.0;
        var newOffset:CGFloat = anOffset + kStep;
        while (newDistance <= aDistance && newOffset < 1.0) {
            newOffset += kStep;
            newDistance = Distance(aPoint,
                                   self.pointForOffset(newOffset));
        }
        return newOffset;
    }
    
    private func pointForOffset(t: CGFloat) -> CGPoint {
        let x = Bezier(t, points[0].x, points[1].x, points[2].x, points[3].x);
        let y = Bezier(t, points[0].y, points[1].y, points[2].y, points[3].y);
        return CGPointMake(x, y);
    }
    
    private func angleForOffset( t: CGFloat) -> CGFloat{
        let dx = BezierPrime(t, points[0].x, points[1].x, points[2].x, points[3].x);
        let dy = BezierPrime(t, points[0].y, points[1].y, points[2].y, points[3].y);
        return atan2(dy, dx);
    }
}

private func Bezier(t: CGFloat, _ P0: CGFloat, _ P1: CGFloat, _ P2 : CGFloat, _ P3: CGFloat) -> CGFloat {
    return
        (1-t)*(1-t)*(1-t)         * P0
        + 3 *       (1-t)*(1-t) *     t * P1
        + 3 *             (1-t) *   t*t * P2
        +                         t*t*t * P3
}

private func BezierPrime( t: CGFloat, _ P0: CGFloat, _ P1: CGFloat, _ P2: CGFloat, _ P3: CGFloat) -> CGFloat{
    return
        -3 * (1-t)*(1-t) * P0
        + (3 * (1-t)*(1-t) * P1) - (6 * t * (1-t) * P1)
        - (3 *         t*t * P2) + (6 * t * (1-t) * P2)
        +  3 * t*t * P3
}

private func Distance( a: CGPoint, _ b: CGPoint) -> CGFloat{
    let dx = a.x - b.x;
    let dy = a.y - b.y;
    return hypot(dx, dy);
}

