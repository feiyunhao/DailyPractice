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
       
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        let color = UIColor(red:red, green:green, blue:blue,alpha: 1)

        let animation:CABasicAnimation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.toValue = color.CGColor
        animation.duration = 1
        animation.delegate = self
        self.colorLayer.addAnimation(animation, forKey: nil)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let baseAnim = anim as! CABasicAnimation
        self.colorLayer.backgroundColor = (baseAnim.toValue as! CGColor)
        CATransaction.commit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorLayer.frame = CGRectMake(0, 0, 100, 100)
        self.colorLayer.backgroundColor = UIColor.blueColor().CGColor;
        self.layerView.layer.addSublayer(colorLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

