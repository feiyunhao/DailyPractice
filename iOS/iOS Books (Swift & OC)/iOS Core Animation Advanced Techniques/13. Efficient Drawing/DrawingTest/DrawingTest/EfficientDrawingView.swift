//
//  EfficientDrawingView.swift
//  DrawingTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class EfficientDrawingView: UIView {

//    Core Animation为这些图形类型的绘制提供了专门的类，并给他们提供硬件支持。CAShapeLayer可以绘制多边形，直线和曲线。CATextLayer可以绘制文本。CAGradientLayer用来绘制渐变。这些总体上都比Core Graphics更快，同时他们也避免了创造一个寄宿图。
    
    let path = UIBezierPath()
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    override func awakeFromNib() {
        let shapeLayer = self.layer as! CAShapeLayer
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 5
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.path.moveToPoint(point!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.path.addLineToPoint(point!)
        (self.layer as! CAShapeLayer).path = self.path.CGPath
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
