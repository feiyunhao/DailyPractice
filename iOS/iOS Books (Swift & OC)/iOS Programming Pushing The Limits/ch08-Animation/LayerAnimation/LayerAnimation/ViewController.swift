//
//  ViewController.swift
//  LayerAnimation
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

extension CALayer {
    
    
}

class ViewController: UIViewController {

    let squareLayer = CALayer()
    let suqareView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        squareLayer.backgroundColor = UIColor.redColor().CGColor
        squareLayer.frame = CGRectMake(100, 100, 20, 20)
        self.view.layer.addSublayer(squareLayer)
        
        suqareView.backgroundColor = UIColor.blueColor()
        suqareView.frame = CGRectMake(200, 100, 20, 20)
        self.view.addSubview(suqareView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(drop(_:)))
        self.view.addGestureRecognizer(tap)
        
    }

    func drop(recognizer: UITapGestureRecognizer) -> () {
        
        //隐式动画
        let toPoint = CGPointMake(200, 250)
//        CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(2)
        squareLayer.position = toPoint
        
        //显式动画
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 1
        anim.toValue = 0
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 2
        self.squareLayer.addAnimation(anim, forKey: "anim")
        
        suqareView.center = CGPointMake(100, 250)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


