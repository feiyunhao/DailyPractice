//
//  ViewController.swift
//  GroupTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(0, 150))
        bezierPath.addCurveToPoint(CGPointMake(300, 150), controlPoint1: CGPointMake(75, 0), controlPoint2: CGPointMake(225, 300))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.lineWidth = 3
        self.containerView.layer.addSublayer(shapeLayer)
        
        let colorLayer = CALayer()
        colorLayer.frame = CGRectMake(0, 0, 64, 64)
        colorLayer.position = CGPointMake(0, 150)
        colorLayer.backgroundColor = UIColor.greenColor().CGColor
        self.containerView.layer.addSublayer(colorLayer)
        
        let positionAnimation = CAKeyframeAnimation()
        positionAnimation.path = bezierPath.CGPath
        positionAnimation.keyPath = "position"
        positionAnimation.rotationMode = kCAAnimationRotateAuto
        
        let colorAnimation = CABasicAnimation()
        colorAnimation.toValue = UIColor.redColor().CGColor
        
        let group = CAAnimationGroup()
        group.animations = [positionAnimation, colorAnimation]
        group.duration = 4
        
        colorLayer.addAnimation(group, forKey: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

