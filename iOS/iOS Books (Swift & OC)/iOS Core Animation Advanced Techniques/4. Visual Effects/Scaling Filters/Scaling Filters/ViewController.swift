//
//  ViewController.swift
//  Scaling Filters
//
//  Created by feiyun on 16/6/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var digitViews: [UIView]!
    
    let calender = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierChinese)
    let units:NSCalendarUnit = [.Hour, .Minute, .Second]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "Digits.png")
        for view in digitViews {
            view.layer.contents = image?.CGImage
            view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0)
            view.layer.contentsGravity = kCAGravityResizeAspect
            view.layer.magnificationFilter = kCAFilterNearest
            
//            总的来说，对于比较小的图或者是差异特别明显，极少斜线的大图，最近过滤算法会保留这种差异明显的特质以呈现更好的结果。但是对于大多数的图尤其是有很多斜线或是曲线轮廓的图片来说，最近过滤算法会导致更差的结果。换句话说，线性过滤保留了形状，最近过滤则保留了像素的差异。
    
        }
        
        self.click()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(click), userInfo: nil, repeats: true)
    }
    
    func click() -> () {
        let components = calender?.components(units, fromDate: NSDate())
        for (index, item) in [components!.hour,
                              components!.minute,
                              components!.second].enumerate() {
            self.setDigit(item / 10, forView: self.digitViews[index * 2])
            self.setDigit(item % 10, forView: self.digitViews[index * 2 + 1])
        }
    }
    
    func setDigit(digit: Int,forView view: UIView) -> () {
        view.layer.contentsRect = CGRectMake(CGFloat(digit) * 0.1, 0, 0.1, 1.0)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

