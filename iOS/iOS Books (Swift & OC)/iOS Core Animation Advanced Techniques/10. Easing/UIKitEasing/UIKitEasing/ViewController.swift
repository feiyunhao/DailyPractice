//
//  ViewController.swift
//  UIKitEasing
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let colorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.colorView.bounds = CGRectMake(0, 0, 100, 100)
        self.colorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2)
        self.colorView.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.colorView)

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseOut, animations: {
            self.colorView.center = (touches.first?.locationInView(self.view!))!
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

