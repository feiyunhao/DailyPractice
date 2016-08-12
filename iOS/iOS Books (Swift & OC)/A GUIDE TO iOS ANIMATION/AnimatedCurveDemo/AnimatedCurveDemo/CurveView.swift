//
//  CurveView.swift
//  AnimatedCurveDemo
//
//  Created by feiyun on 16/8/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CurveView: UIView {

    var progress: CGFloat = 0.0 {
        didSet{
            curveLayer.progress = progress
            curveLayer.setNeedsDisplay()
        }
    }
    
    private var curveLayer: CurveLayer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        curveLayer = CurveLayer()
        curveLayer.frame = bounds
        curveLayer.contentsScale = UIScreen.mainScreen().scale
        curveLayer.progress = 0.0
        curveLayer.setNeedsDisplay()
        layer.addSublayer(curveLayer)
    }

    

}
