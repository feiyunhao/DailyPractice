//
//  CustomView.swift
//  理解坐标系
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CustomView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 3)
        
        CGContextMoveToPoint(context, 10, 100)
        CGContextAddLineToPoint(context, 200, 100)
        CGContextStrokePath(context)
        
        CGContextMoveToPoint(context, 10, 105.5)
        CGContextAddLineToPoint(context, 200, 105.5)
        CGContextStrokePath(context)
    }
    

}
