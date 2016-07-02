//
//  ViewController.swift
//  PresentationLayerTest
//
//  Created by feiyun on 16/7/1.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let colorLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.colorLayer.frame = CGRectMake(0, 0, 100, 100)
        self.colorLayer.position = self.view.layer.position
        self.colorLayer.backgroundColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(colorLayer)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(self.view)
        if let _ = self.colorLayer.presentationLayer()?.hitTest(point!) {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            let color = UIColor(red:red, green:green, blue:blue,alpha: 1)
            self.colorLayer.backgroundColor = color.CGColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            self.colorLayer.position = point!
            CATransaction.commit()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

