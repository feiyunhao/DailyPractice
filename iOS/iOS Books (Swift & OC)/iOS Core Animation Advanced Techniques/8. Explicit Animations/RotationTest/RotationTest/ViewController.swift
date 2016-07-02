//
//  ViewController.swift
//  RotationTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 12, 128)
        layer.backgroundColor = UIColor.redColor().CGColor
        layer.position = self.view.layer.position
        self.view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2
//        animation.toValue = NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1))
        animation.byValue = NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI*2), 0, 0, 1))
        
        layer.addAnimation(animation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

