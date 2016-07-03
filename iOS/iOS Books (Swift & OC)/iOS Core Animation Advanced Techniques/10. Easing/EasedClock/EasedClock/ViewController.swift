//
//  ViewController.swift
//  EasedClock
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!
    
    let canlender = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierHebrew)
    let units: NSCalendarUnit = [.Hour,.Minute,.Second]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
        
        self.setUpHandAnimated(false)
    }

    func click() -> () {
        self.setUpHandAnimated(true)
    }
    
    func setUpHandAnimated(animated:Bool) -> () {
        let components = canlender?.components(units, fromDate: NSDate())
        let hourAngle = CGFloat(Double((components?.hour)!) / 12.0 * M_PI * 2)
        let minuteAngle = CGFloat(Double((components?.minute)!) / 60.0 * M_PI * 2)
        let secondAngle = CGFloat(Double((components?.second)!) / 60.0 * M_PI * 2)
        
        self.setAngle(hourAngle, forHang: hourHand, animated: animated)
        self.setAngle(minuteAngle, forHang: minuteHand, animated: animated)
        self.setAngle(secondAngle, forHang: secondHand, animated: animated)
    }
    
    func setAngle(angle: CGFloat,forHang hangView: UIView,animated: Bool) -> () {
        let transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        if animated {
            let animation = CABasicAnimation()
            animation.keyPath = "transform"
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction.init(controlPoints: 1, 0, 0.75, 1)
            animation.fromValue = hangView.layer.presentationLayer()?.valueForKey("transform")
            animation.toValue = NSValue.init(CATransform3D: transform)
            hangView.layer.transform = transform
            hangView.layer.addAnimation(animation, forKey: nil)
        } else {
            hangView.layer.transform = transform
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

