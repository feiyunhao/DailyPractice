//
//  ViewController.swift
//  CustonTransition
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func performTransition(sender: AnyObject) {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, UIScreen.mainScreen().scale)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let coverView = UIImageView.init(image: coverImage)
        coverView.frame = self.view.bounds
        self.view.addSubview(coverView)
        
        let red = CGFloat(arc4random())/CGFloat(UInt32.max)
        let green = CGFloat(arc4random())/CGFloat(UInt32.max)
        let blue = CGFloat(arc4random())/CGFloat(UInt32.max)
        self.view.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        
        UIView.animateWithDuration(1, animations: { 
            var transiform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            transiform = CGAffineTransformScale(transiform, 0.01, 0.01)
            coverView.transform = transiform
            coverView.alpha = 0
        }) { (compeleted) in
                coverView.removeFromSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

