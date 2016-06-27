//
//  ViewController.swift
//  anchorPoint
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourHand: UIImageView!
    @IBOutlet weak var minuteHand: UIImageView!
    @IBOutlet weak var secondHand: UIImageView!
    
    let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierChinese)
    let units: NSCalendarUnit = [.Hour, .Minute, .Second]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9)
        
        self.click()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(click), userInfo: nil, repeats: true).fire()
    }

    func click() -> () {
        
        let components:NSDateComponents = (calendar?.components(units, fromDate: NSDate()))!
        print(components.hour)
        let hourAngle   = Double(components.hour) / 12.0 * M_PI * 2.0
        let minuteAngle = Double(components.minute) / 60.0 * M_PI * 2.0
        let secondAngle = Double(components.second) / 60.0 * M_PI * 2.0
        
        self.hourHand.transform = CGAffineTransformMakeRotation(CGFloat(hourAngle));
        self.minuteHand.transform = CGAffineTransformMakeRotation(CGFloat(minuteAngle));
        self.secondHand.transform = CGAffineTransformMakeRotation(CGFloat(secondAngle));
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

