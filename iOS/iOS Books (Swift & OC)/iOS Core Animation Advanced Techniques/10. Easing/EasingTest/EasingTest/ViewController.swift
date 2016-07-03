//
//  ViewController.swift
//  EasingTest
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorLayer.frame = CGRectMake(0, 0, 100, 100);
        self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2.0,
                                               self.view.bounds.size.height / 2.0);
        self.colorLayer.backgroundColor = UIColor.redColor().CGColor;
        self.view.layer.addSublayer(self.colorLayer)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut))
        self.colorLayer.position = (touches.first?.locationInView(self.view!))!
        CATransaction.commit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

