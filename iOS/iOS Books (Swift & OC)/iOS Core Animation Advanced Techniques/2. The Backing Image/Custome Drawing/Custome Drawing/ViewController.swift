//
//  ViewController.swift
//  Custome Drawing
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 150, 150)
        layer.backgroundColor = UIColor.blueColor().CGColor
        self.view.layer.addSublayer(layer)
        layer.delegate = self
        
//        layer.setNeedsDisplay()
//        layer.displayIfNeeded()
        layer.display()
        
    }

    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextSetLineWidth(ctx, 10.0);
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor);
        CGContextStrokeEllipseInRect(ctx, layer.bounds);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

