//
//  DrawingView.swift
//  Chalkboard
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

private let BRUSH_SIZE:CGFloat = 32

class DrawingView: UIView {
    
//    这个实现在模拟器上表现还不错，但是在真实设备上就没那么好了。问题在于每次手指移动的时候我们就会重绘之前的线刷，即使场景的大部分并没有改变。我们绘制地越多，就会越慢。随着时间的增加每次重绘需要更多的时间，帧数也会下降
    var strokes: [NSValue] = []
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.addBrushStrokeAtPoint(point!)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self)
        self.addBrushStrokeAtPoint(point!)
    }
    
    func addBrushStrokeAtPoint(point: CGPoint) -> () {
        self.strokes.append(NSValue.init(CGPoint: point))
        self.setNeedsDisplay()
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        for value in self.strokes {
            let point = value.CGPointValue()
            let brushRect = CGRectMake(point.x - BRUSH_SIZE / 2, point.y - BRUSH_SIZE / 2, BRUSH_SIZE, BRUSH_SIZE)
            UIImage(named: "Chalk")?.drawInRect(brushRect)
            
        }
    }
    

}
