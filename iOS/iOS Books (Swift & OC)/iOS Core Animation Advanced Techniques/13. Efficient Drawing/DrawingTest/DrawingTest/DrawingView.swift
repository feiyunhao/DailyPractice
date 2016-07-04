//
//  DrawingView.swift
//  DrawingTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
//    这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。看来
    
    let path = UIBezierPath()
    
    override func awakeFromNib() {
        path.lineJoinStyle = .Round
        path.lineCapStyle = .Round
        path.lineWidth = 5
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.path.moveToPoint(point!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.path.addLineToPoint(point!)
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.clearColor().setFill()
        UIColor.redColor().setStroke()
        self.path.stroke()
    }
}
