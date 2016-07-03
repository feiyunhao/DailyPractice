//
//  ViewController.swift
//  BouncyBall
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    let ballView = UIImageView(frame:CGRectMake(0, 0, 64, 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ballView.layer.cornerRadius = 32
        ballView.backgroundColor = UIColor.redColor()
        self.containerView.addSubview(ballView)
        self.animate()
    }

    func animate() -> () {
        self.ballView.center = CGPointMake(150, 32)
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 2
        animation.values = [NSValue(CGPoint:CGPointMake(150, 32)),
                            NSValue(CGPoint:CGPointMake(150, 268)),
                            NSValue(CGPoint:CGPointMake(150, 140)),
                            NSValue(CGPoint:CGPointMake(150, 268)),
                            NSValue(CGPoint:CGPointMake(150, 220)),
                            NSValue(CGPoint:CGPointMake(150, 268)),
                            NSValue(CGPoint:CGPointMake(150, 250)),
                            NSValue(CGPoint:CGPointMake(150, 268))]
        animation.timingFunctions = [
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn),
        ]
        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]
        
        self.ballView.layer.position = CGPointMake(150, 268)
        self.ballView.layer.addAnimation(animation, forKey: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.animate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

