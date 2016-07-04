//
//  DrawingView.swift
//  Chalkboard
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

private let BRUSH_SIZE:CGFloat = 32

class DrawingView2: UIView {
    
//    那些需要重绘的部分被称作『脏区域』。在实际应用中，鉴于非矩形区域边界裁剪和混合的复杂性，通常会区分出包含指定视图的矩形位置，而这个位置就是『脏矩形』。
    
    var strokes: [NSValue] = []
    
    override func awakeFromNib() {
        self.layer.drawsAsynchronously = true
    }
    
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
        self.setNeedsDisplayInRect(CGRectMake(point.x - BRUSH_SIZE/2,
            point.y - BRUSH_SIZE/2,
            BRUSH_SIZE, BRUSH_SIZE))
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        for value in self.strokes {
            let point = value.CGPointValue()
            let brushRect = CGRectMake(point.x - BRUSH_SIZE / 2, point.y - BRUSH_SIZE / 2, BRUSH_SIZE, BRUSH_SIZE)
            if CGRectIntersectsRect(rect, brushRect) {
                UIImage(named: "Chalk")?.drawInRect(brushRect)
            }
        }
    }
    
    
}
