//
//  ViewController.swift
//  CurvyText
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let curvyTextView = CurvyTextView(frame:self.view.bounds)
        self.view.addSubview(curvyTextView)
        
        let string = "You can display text along a curve, with bold, color, and big text."
        
        let attributedString = NSMutableAttributedString.init(string: string, attributes: [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
        
        attributedString.addAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(16)],
                                       range: (string as NSString).rangeOfString("blod"))
         attributedString.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()],
                                        range: (string as NSString).rangeOfString("color"))
         attributedString.addAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(32)],
                                        range: (string as NSString).rangeOfString("big text"))
        
        curvyTextView.attributedString = attributedString
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

