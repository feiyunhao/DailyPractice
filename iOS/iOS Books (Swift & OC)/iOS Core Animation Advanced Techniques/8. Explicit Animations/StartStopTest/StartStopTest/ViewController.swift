//
//  ViewController.swift
//  StartStopTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shipLayer = CALayer()
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func start(sender: AnyObject) {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2
        animation.byValue = M_PI*2
        animation.delegate = self
        self.shipLayer.addAnimation(animation, forKey: nil)
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.shipLayer.removeAnimationForKey("transform.rotation")
        self.shipLayer.removeAllAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shipLayer.frame = CGRectMake(0, 0, 128, 128)
        self.shipLayer.position = CGPointMake(150, 150)
        self.shipLayer.contents = UIImage(named: "Spaceship")!.CGImage;
        self.containerView.layer.addSublayer(self.shipLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

