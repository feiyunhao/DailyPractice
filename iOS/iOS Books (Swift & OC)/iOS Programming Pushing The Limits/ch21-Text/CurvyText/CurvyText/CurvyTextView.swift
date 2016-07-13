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
    
    func drawPath() {
        let path = UIBezierPath()
        path.moveToPoint(points[0])
        path.addCurveToPoint(points[3], controlPoint1: points[1], controlPoint2: points[2])
        UIColor.blackColor().setStroke()
        path.stroke()
    }
    
    // MARK: - text
    
    func drawText() {
        
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.drawPath()
        self.drawText()
    }
    
    func pointForOffset(t: CGFloat) -> CGPoint {
    let x = Bezier(t, P0: points[0].x, P1: points[0].x, P2: points[0].x, P3: points[0].x);
    let y = Bezier(t, P0: points[0].y, P1: points[0].y, P2: points[0].y, P3: points[0].y);
    return CGPointMake(x, y);
    }
}

private func Bezier(t: CGFloat, P0: CGFloat,  P1: CGFloat, P2 : CGFloat,
P3: CGFloat) -> CGFloat {
    return
    (1-t)*(1-t)*(1-t)         * P0
        + 3 *       (1-t)*(1-t) *     t * P1
        + 3 *             (1-t) *   t*t * P2
        +                         t*t*t * P3;
    }
    


static CGFloat BezierPrime(CGFloat t, CGFloat P0, CGFloat P1,
CGFloat P2, CGFloat P3) {
    return
    -  3 * (1-t)*(1-t) * P0
        + (3 * (1-t)*(1-t) * P1) - (6 * t * (1-t) * P1)
        - (3 *         t*t * P2) + (6 * t * (1-t) * P2)
        +  3 * t*t * P3;
    }
    
    - (CGFloat)angleForOffset:(CGFloat)t {
        CGFloat dx = BezierPrime(t, _P0.x, _P1.x, _P2.x, _P3.x);
        CGFloat dy = BezierPrime(t, _P0.y, _P1.y, _P2.y, _P3.y);
        return atan2(dy, dx);
}

static CGFloat Distance(CGPoint a, CGPoint b) {
    CGFloat dx = a.x - b.x;
    CGFloat dy = a.y - b.y;
    return hypot(dx, dy);
}

