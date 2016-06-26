//
//  FlowerTransformView.swift
//  Transforms
//
//  Created by feiyun on 16/6/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class FlowerTransformView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.redColor().set()
        
        let size = self.frame.size
        let margin: CGFloat = 10.0 * 2
        
        UIColor.redColor().set()
        let path = UIBezierPath()
        
        path.addArcWithCenter(CGPointMake(0, -1),
                              radius: 1,
                              startAngle: CGFloat(-M_PI),
                              endAngle: CGFloat(0),
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(1, 0),
                              radius: 1,
                              startAngle: CGFloat(-M_PI_2),
                              endAngle: CGFloat(M_PI_2),
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(0, 1),
                              radius: 1,
                              startAngle: CGFloat(0),
                              endAngle: CGFloat(-M_PI),
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(-1, 0),
                              radius: 1,
                              startAngle: CGFloat(M_PI_2),
                              endAngle: CGFloat(-M_PI_2),
                              clockwise: true)
        
        let min = size.width < size.height ? size.width : size.height
        
        let scale = (min - margin) / 4
        let transform: CGAffineTransform = CGAffineTransformMake(scale, 0, 0, scale, size.width/2, size.height/2)
        path.applyTransform(transform)
        
        path.fill()
        
    }
 

}
