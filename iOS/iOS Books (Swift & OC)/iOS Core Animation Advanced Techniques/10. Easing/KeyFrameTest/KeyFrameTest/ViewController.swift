//
//  ViewController.swift
//  KeyFrameTest
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    let colorLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.colorLayer.frame = CGRectMake(50.0, 50.0, 100.0, 100.0)
        self.colorLayer.backgroundColor = UIColor.blueColor().CGColor
        
        //add it to our view
        self.layerView.layer.addSublayer(self.colorLayer)
    }

    @IBAction func changeColor(sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2
        animation.values = [UIColor.blueColor().CGColor,
                            UIColor.redColor().CGColor,
                            UIColor.greenColor().CGColor,
                            UIColor.blueColor().CGColor]
        let fn = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        animation.timingFunctions = [fn,fn,fn]
        colorLayer.addAnimation(animation, forKey: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

