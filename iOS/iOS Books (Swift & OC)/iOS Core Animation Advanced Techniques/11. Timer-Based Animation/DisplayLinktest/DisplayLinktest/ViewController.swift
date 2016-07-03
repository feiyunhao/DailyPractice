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
    var timer: CADisplayLink?
    let duration: CFTimeInterval = 1.0
    var timeOffset: CFTimeInterval = 0.0
    var lastStep: CFTimeInterval = 0.0
    let fromValue = NSValue(CGPoint:CGPointMake(150, 32))
    let toValue = NSValue(CGPoint:CGPointMake(150, 268))
    
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
        self.timer?.invalidate()
        self.lastStep = CACurrentMediaTime()
        self.timer = CADisplayLink.init(target: self, selector: #selector(step(_:)))
        self.timer?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)

    }
    
    func step(step: NSTimer) -> () {
        
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - self.lastStep
        self.lastStep = thisStep
        
        //update time offset
        self.timeOffset = min(self.timeOffset + stepDuration, self.duration)
        
        //get normalized time offset (in range 0 - 1)
        var time = Float(self.timeOffset / self.duration)
        
        //apply easing
        time = self.bounceEaseOut(Float(time))
        
        //interpolate position
        let position = self.interpolateFromValue(self.fromValue, toValue: self.toValue, time: time)
        
        //move ball view to new position
        self.ballView.center = position.CGPointValue
        
        //stop the timer if we've reached the end of the animation
        if self.timeOffset >= self.duration
        {
            self.timer!.invalidate()
            self.timer = nil;
            self.timeOffset = 0
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.animate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

