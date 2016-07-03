//
//  ViewController.swift
//  TimeOffsetTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeOffsetLabel: UILabel!
    @IBOutlet weak var timeOffsetSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    let bezierPath = UIBezierPath()
    let shipLayer = CALayer()
    
   
    @IBAction func start(sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.timeOffset = Double(self.timeOffsetSlider.value)
        animation.speed = self.speedSlider.value
        animation.duration = 1
        animation.path = bezierPath.CGPath
        animation.rotationMode = kCAAnimationRotateAuto
        animation.removedOnCompletion = false
        shipLayer.addAnimation(animation, forKey: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bezierPath.moveToPoint(CGPointMake(0, 150))
        bezierPath.addCurveToPoint(CGPointMake(300, 150), controlPoint1: CGPointMake(75, 0), controlPoint2: CGPointMake(225, 300))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        containerView.layer.addSublayer(shapeLayer)
        
        shipLayer.frame = CGRectMake(0, 0, 64, 64)
        shipLayer.position = CGPointMake(0, 150)
        shipLayer.contents = UIImage(named:"Spaceship")!.CGImage;
        containerView.layer.addSublayer(shipLayer)
        
        self.upDateSlider()
    }
    
    @IBAction func upDateSlider() {
        let timeOffset = timeOffsetSlider.value
        self.timeOffsetLabel.text = String(format: "%.2f",timeOffset)
        let speed = self.speedSlider.value;
        self.speedLabel.text =  String(format: "%.2f",speed)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

