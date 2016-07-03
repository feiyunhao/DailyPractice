//
//  ViewController.swift
//  AutoreverseTest
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
        let doorLayer = CALayer()
        doorLayer.frame = CGRectMake(0, 0, 128, 256)
        doorLayer.position = CGPointMake(150 - 64, 150)
        doorLayer.anchorPoint = CGPointMake(0, 0.5)
        doorLayer.contents = UIImage(named:"Door.png")!.CGImage
        self.containerView.layer.addSublayer(doorLayer)
        
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.containerView.layer.sublayerTransform = perspective
        
        //apply swinging animation
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y";
        animation.toValue = -M_PI_2
        animation.duration = 2.0;
        animation.repeatDuration = Double(MAXFLOAT);
        animation.autoreverses = true
        doorLayer.addAnimation(animation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

