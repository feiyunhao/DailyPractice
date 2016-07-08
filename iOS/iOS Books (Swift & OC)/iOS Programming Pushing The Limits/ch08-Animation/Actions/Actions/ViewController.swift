//
//  ViewController.swift
//  Actions
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let circleLayer = CircleLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.grayColor()
        circleLayer.radius = 20
        circleLayer.frame = self.view.bounds
        
        
        let animation = CABasicAnimation.init(keyPath: "position")
        var actions = circleLayer.actions ?? [:]
        
        actions["position"] = animation
        
        let fadeAnim = CABasicAnimation.init(keyPath: "opacity")
        fadeAnim.fromValue = NSValue(nonretainedObject:0.1)
        fadeAnim.toValue = NSValue(nonretainedObject:1)
        
        let growAnim = CABasicAnimation.init(keyPath: "transform.scale")
        growAnim.fromValue = NSValue(nonretainedObject:0.1)
        growAnim.toValue = NSValue(nonretainedObject:5)
        
        let color = CABasicAnimation.init(keyPath: "backgroundColor")
        color.fromValue = UIColor.redColor().CGColor
        color.toValue = UIColor.blueColor().CGColor
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [fadeAnim, growAnim, color]

        actions[kCAOnOrderIn] = groupAnim

        circleLayer.actions = actions
        
        self.view.layer.addSublayer(circleLayer)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        circleLayer.position = CGPointMake(100, 100)
        circleLayer.radius = 100
//        CATransaction.commit()
//        circleLayer.radius = 100

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

