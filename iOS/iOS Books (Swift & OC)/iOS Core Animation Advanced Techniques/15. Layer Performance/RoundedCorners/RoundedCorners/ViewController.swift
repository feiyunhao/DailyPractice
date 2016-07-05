//
//  ViewController.swift
//  RoundedCorners
//
//  Created by feiyun on 16/7/5.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var layerView1: UIView!

    @IBOutlet weak var layerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.layerView1.bounds
        shapeLayer.fillColor = UIColor.redColor().CGColor
        shapeLayer.path = UIBezierPath.init(roundedRect: shapeLayer.bounds, cornerRadius: 20).CGPath
        self.layerView1.layer.addSublayer(shapeLayer)
        
        let blueLayer = CALayer()
        blueLayer.frame = self.layerView2.bounds
        blueLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0)
        blueLayer.contentsScale = UIScreen.mainScreen().scale
        blueLayer.contents = UIImage(named: "Rounded")?.CGImage
        self.layerView2.layer.addSublayer(blueLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

