//
//  GraphView.swift
//  Graph
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class GraphView: UIView {

    var values: [Double] = []
    let timer: dispatch_source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let delayInSecond: UInt64 = 100
        dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), delayInSecond * NSEC_PER_MSEC, 0)
        dispatch_source_set_event_handler(timer) { 
            [weak self] in
            self!.updateValue()
        }
        dispatch_resume(timer)
    }
    
    let kXScale:CGFloat = 5.0
    let kYScale:CGFloat = 100.0
    
    func updateValue() -> () {
        let nextValue:Double = sin(CFAbsoluteTimeGetCurrent()) + Double(rand()) / Double(RAND_MAX)
        print(nextValue)
        values.append(nextValue)
        let size = self.bounds.size
        let maxDimension = size.width > size.height ? size.width : size.height
        let maxValue = Int(floor(maxDimension / kXScale))
        let n = values.count - maxValue
        if n > 0 {
            values[0...n] = []
        }
        self.setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if values.count == 0 {
            return
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineJoin(ctx, .Round)
        CGContextSetLineWidth(ctx, 10)
        
        let path = CGPathCreateMutable()
        let yOffset = self.bounds.size.height / 2;
        var transform = CGAffineTransformMake(kXScale, 0, 0, kYScale, 0, yOffset)
        let y = CGFloat(values.first!)
        
        CGPathMoveToPoint(path, &transform, 0, y)
        for (index, item) in values.enumerate() {
            CGPathAddLineToPoint(path, &transform, CGFloat(index), CGFloat(item))
        }
        CGContextAddPath(ctx, path)
        CGContextStrokePath(ctx)
        
    }
    
}
