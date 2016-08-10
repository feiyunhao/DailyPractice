//
//  CircleView.swift
//  AnimatedCircleDemo
//
//  Created by feiyun on 16/8/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var circleLayer = CircleLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        circleLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
