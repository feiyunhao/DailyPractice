//
//  ViewController.swift
//  Parallax
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import QuartzCore

import UIKit





class FirstController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scrollView: UIScrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING,
                                                 (HEIGHT - 1)*SPACING)
        self.view.addSubview(scrollView)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / CAMERA_DISTANCE
        scrollView.layer.sublayerTransform = transform
        
        for z in (0..<Int(DEPTH)).reverse()
        {
            for y in 0..<Int(HEIGHT)
            {
                for x in 0..<Int(WIDTH)
                {
                    let layer = CALayer()
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE)
                    layer.position = CGPointMake(CGFloat(x)*SPACING, CGFloat(y)*SPACING);
                    layer.zPosition = -CGFloat(z)*SPACING;
                    
                    //set background color
                    layer.backgroundColor = UIColor(white: 1 - CGFloat(z)*(1.0/DEPTH), alpha:1).CGColor
                    
                    //attach to scroll view
                    scrollView.layer.addSublayer(layer)
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

