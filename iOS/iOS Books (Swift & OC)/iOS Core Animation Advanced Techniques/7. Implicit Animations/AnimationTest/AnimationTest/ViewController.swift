//
//  ViewController.swift
//  AnimationTest
//
//  Created by feiyun on 16/7/1.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var layerView: UIView!
    let colorLayer = CALayer()
    
    @IBAction func changeColor(sender: AnyObject) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationDuration(1)//0.25
        CATransaction.setCompletionBlock {
            var transform = self.colorLayer.affineTransform()
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_4))
            self.colorLayer.setAffineTransform(transform)
        }
        
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        let color = UIColor(red:red, green:green, blue:blue,alpha: 1)
        self.colorLayer.backgroundColor = color.CGColor
        
        self.layerView.layer.backgroundColor = UIColor(red:red, green:green, blue:blue,alpha: 1).CGColor
        
        CATransaction.commit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorLayer.frame = CGRectMake(0, 0, 100, 100)
        self.colorLayer.backgroundColor = UIColor.blueColor().CGColor;
        self.layerView.layer.addSublayer(colorLayer)
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.colorLayer.actions = ["backgroundColor" : transition]
        
        
        print(self.layerView.actionForLayer(self.layerView.layer, forKey: "backgroundColor"))
        UIView.beginAnimations(nil, context: nil)
        print(self.layerView.actionForLayer(self.layerView.layer, forKey: "backgroundColor"))
        UIView.commitAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

