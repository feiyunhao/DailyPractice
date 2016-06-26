//
//  FlowerView.swift
//  Paths
//
//  Created by feiyun on 16/6/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import Darwin
class FlowerView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let size = self.bounds.size
        let margin:CGFloat = 10
        let min = size.height < size.width ? size.height : size.width
        //使用rintf（四舍五入）来保证点对齐
        let radius = CGFloat(rintf(Float((min - margin) / 4)))
        
        let offset = rintf(Float((size.height - size.width)/2))
        var yOffSet:CGFloat = 0
        var xOffSet:CGFloat = 0
        
        if offset > 0 {
            xOffSet = CGFloat(rint(margin / 2))
            yOffSet = CGFloat(offset);
        } else {
            xOffSet = CGFloat(-offset);
            yOffSet = CGFloat(rintf(Float(margin) / 2))
        }
        
        UIColor.redColor().setFill()
        
        let path = UIBezierPath()
        
        path.addArcWithCenter(CGPointMake(radius * 2 + xOffSet, radius + yOffSet),
                              radius: radius,
                              startAngle: CGFloat(-M_PI),
                              endAngle: 0,
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(radius * 3 + xOffSet, radius * 2 + yOffSet),
                              radius: radius,
                              startAngle: CGFloat(-M_PI_2),
                              endAngle: CGFloat(M_PI_2),
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(radius * 2 + xOffSet, radius * 3 + yOffSet),
                              radius: radius,
                              startAngle: 0,
                              endAngle: CGFloat(M_PI),
                              clockwise: true)
        
        path.addArcWithCenter(CGPointMake(radius + xOffSet , radius * 2 + yOffSet),
                              radius: radius,
                              startAngle: CGFloat(M_PI_2),
                              endAngle: CGFloat(-M_PI_2),
                              clockwise: true)
        
        path.closePath()
        path.fill()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentMode = .Redraw
    }

}
