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

    func interpolate(from:Float,_ to:Float,_ time:Float) -> Float {
        return (to - from) * time + from
    }

    func bounceEaseOut(t: Float) -> Float {
        if (t < 4/11.0)
        {
            return (121 * t * t)/16.0
        }
        else if (t < 8/11.0)
        {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
        }
        else if (t < 9/10.0)
        {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }

    func interpolateFromValue(fromValue:AnyObject, toValue:AnyObject, time:Float) -> AnyObject {
        if fromValue is NSValue {
            let type = fromValue.objCType
            if strcmp(type, NSValue(CGPoint:CGPointZero).objCType) == 0 {
                let from = fromValue.CGPointValue
                let to = toValue.CGPointValue
                let result = CGPointMake(CGFloat(self.interpolate(Float(from.x), Float(to.x), Float(time))),
                                         CGFloat(self.interpolate(Float(from.y), Float(to.y), Float(time))));
                return NSValue(CGPoint:result)
            }
        }
        return time < 0.5 ? fromValue : toValue
    }
    
    func animate() -> () {
        self.ballView.center = CGPointMake(150, 32)
        
        let fromValue = NSValue(CGPoint:CGPointMake(150, 32))
        let toValue = NSValue(CGPoint:CGPointMake(150, 268))
        let duration:CFTimeInterval = 1
        
        let numFrames = Int(duration * 60)
        var frams: [AnyObject] = []
        for i in 0...numFrames {
            var time = Float(1.0/Float(numFrames)) * Float(i)
            time = self.bounceEaseOut(time);
            frams.append(self.interpolateFromValue(fromValue, toValue: toValue, time: time))
        }
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1
        animation.values = frams
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

