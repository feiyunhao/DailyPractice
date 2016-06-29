//
//  ViewController.swift
//  LayerTest
//
//  Created by feiyun on 16/6/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var layerView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
//        layerView.layer.setAffineTransform(transform)
        
        
//        //create a new transform
//        var transform = CGAffineTransformIdentity;
//        
//        //scale by 50%
//        transform = CGAffineTransformScale(transform, 0.5, 0.5);
//        
//        //rotate by 30 degrees
//        transform = CGAffineTransformRotate(transform, CGFloat(M_PI) / 180.0 * 30.0);
//        
//        //translate by 200 points
//        transform = CGAffineTransformTranslate(transform, 200, 0);
//        
//        //apply transform to layer
//        self.layerView.layer.setAffineTransform(transform)

        
        
//        var transform = CGAffineTransformIdentity
//        print(transform.a,transform.b,transform.c,transform.d,transform.tx,transform.ty)
//        transform.c = -0.5
//        transform.b = 0.5
//        self.layerView.layer.setAffineTransform(transform)
        
        
//        let transform3D = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 1.9, 0)
//        self.layerView.layer.transform = transform3D
        
        
        
//        var transform = CATransform3DIdentity
//        //apply perspective
//        transform.m34 = -1.0 / 500.0;
//        //rotate by 45 degrees along the Y axis
//        transform = CATransform3DRotate(transform, CGFloat(M_PI_4), 0, 1, 0);
//        //apply to layer
//        self.layerView.layer.transform = transform;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

