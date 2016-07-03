//
//  ViewController.swift
//  ManualAnimation
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    let doorLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        doorLayer.frame = CGRectMake(0, 0, 128, 256)
        doorLayer.position = CGPointMake(150 - 64, 150)
        doorLayer.anchorPoint = CGPointMake(0, 0.5)
        doorLayer.contents = UIImage(named:"Door.png")!.CGImage
        self.containerView.layer.addSublayer(doorLayer)
        
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.containerView.layer.sublayerTransform = perspective
        
        let pan = UIPanGestureRecognizer(target: self,action: #selector(pan(_:)))
        self.view.addGestureRecognizer(pan)
        
        doorLayer.speed = 0
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = -M_PI+M_PI_4
        animation.duration = 1
        self.doorLayer.addAnimation(animation, forKey: nil)
        
    }

    func pan(pan: UIPanGestureRecognizer) -> () {
        var x = pan.translationInView(self.view).x
        print(x)
        x /= 200.0
        var timeOffset = self.doorLayer.timeOffset
        timeOffset = min(0.999, max(0.0, timeOffset - Double(x)))
        self.doorLayer.timeOffset = timeOffset
        pan.setTranslation(CGPointZero, inView: self.view)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

