//
//  ViewController.swift
//  LayerTest2
//
//  Created by feiyun on 16/6/29.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var layerView1: UIImageView!
    @IBOutlet weak var layerView2: UIImageView!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var inerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/500.0
        self.containerView.layer.sublayerTransform = perspective
        
        let transform1 = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 1, 0)
        self.layerView1.layer.transform = transform1
        let transform2 = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, -1, 0)
        self.layerView2.layer.transform = transform2
        
//        let outer = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
//        let inner = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, -1)
//        outerView.layer.transform = outer
//        inerView.layer.transform = inner
        
        var outer = CATransform3DIdentity;
        outer.m34 = -1.0 / 500.0;
        outer = CATransform3DRotate(outer, CGFloat(M_PI_4), 0, 1, 0);
        self.outerView.layer.transform = outer;
        //rotate the inner layer -45 degrees
        var inner = CATransform3DIdentity;
        inner.m34 = -1.0 / 500.0;
        inner = CATransform3DRotate(inner, -CGFloat(M_PI_4), 0, 1, 0);
        self.inerView.layer.transform = inner;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

