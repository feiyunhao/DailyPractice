//
//  ViewController.swift
//  PathTest
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
        
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.CGPath
        pathLayer.fillColor = UIColor.clearColor().CGColor
        pathLayer.strokeColor = UIColor.redColor().CGColor
        pathLayer.lineWidth = 3
        self.containerView.layer.addSublayer(pathLayer)
        
        let shapLayer = CALayer()
        shapLayer.frame = CGRectMake(0, 0, 64, 64)
        shapLayer.position = CGPointMake(0, 150)
        shapLayer.contents = UIImage(named: "Ship")?.CGImage
        self.containerView.layer.addSublayer(shapLayer)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 4
        animation.path = bezierPath.CGPath
        animation.rotationMode = kCAAnimationRotateAuto
        shapLayer.addAnimation(animation, forKey: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

