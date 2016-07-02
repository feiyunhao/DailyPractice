//
//  ViewController.swift
//  ClockFace
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!
    
    let calender = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierHebrew)
    let units: NSCalendarUnit = [.Hour, .Minute, .Second]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        
        self.updateHandsAnimated(false)
        
         NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
    }

    func click() {
        self.updateHandsAnimated(true)
    }
    
    func updateHandsAnimated(animated: Bool) {
        let components = calender?.components(units, fromDate: NSDate())
        let hourAngle   = Double(components!.hour) / 12.0 * M_PI * 2.0
        let minuteAngle = Double(components!.minute) / 60.0 * M_PI * 2.0
        let secondAngle = Double(components!.second) / 60.0 * M_PI * 2.0
        
        self.setAngle(CGFloat(hourAngle), forHand: hourHand, animated: animated)
        self.setAngle(CGFloat(minuteAngle), forHand: minuteHand, animated: animated)
        self.setAngle(CGFloat(secondAngle), forHand: secondHand, animated: animated)

    }
    
    func setAngle(angle:CGFloat, forHand handView:UIView, animated:Bool) {
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        if animated {
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.toValue = NSValue(CATransform3D:transform)
            animation.duration = 1
            animation.setValue(handView, forKey: "handView")
            animation.delegate = self
            handView.layer.addAnimation(animation, forKey: nil)
            
        } else {
            handView.layer.transform = transform
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let baseAnimation = anim as! CABasicAnimation
        
        let handView = anim.valueForKey("handView")
        handView?.layer.transform = (baseAnimation.toValue?.CATransform3DValue!)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

