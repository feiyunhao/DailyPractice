//
//  Hypnosister.swift
//  Hypnosister
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class Hypnosister: UIView {

    var circleColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let red = CGFloat(arc4random() % 100) / 100.0
        let green = CGFloat(arc4random() % 100) / 100.0
        let blue = CGFloat(arc4random() % 100) / 100.0
        self.circleColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        self.setNeedsDisplay()
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let bounds = self.bounds
        let center = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2)
        let maxRadius = hypot(bounds.size.height, bounds.size.width)/2
        let path = UIBezierPath()
        
        for i in 0...Int(maxRadius/20) {
            let currentRadius = CGFloat(i*20)
            path.moveToPoint(CGPointMake(center.x +  currentRadius, center.y))
            path.addArcWithCenter(center, radius: currentRadius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        }
        
        path.lineWidth = 10
        self.circleColor.setStroke()
        path.stroke()
        
    }
    

}
