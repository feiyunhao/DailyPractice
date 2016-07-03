//
//  ViewController.swift
//  EasingGraph
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let function = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        var controlPoint1:CGPoint = CGPointZero
        var controlPoint2:CGPoint = CGPointZero
        
// TODO:::      CGPoint 指针怎么转 UnsafeMutablePointer<Float> 
        
//        function.getControlPointAtIndex(1, values: &controlPoint1)
//        function.getControlPointAtIndex(2, values: &controlPoint2)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointZero)
        bezierPath.addCurveToPoint(CGPointMake(1, 1), controlPoint1:
            controlPoint1, controlPoint2: controlPoint2)
        bezierPath.applyTransform(CGAffineTransformMakeScale(200, 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = bezierPath.CGPath
        self.layerView.layer.addSublayer(shapeLayer)
        
        self.layerView.layer.geometryFlipped = true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

