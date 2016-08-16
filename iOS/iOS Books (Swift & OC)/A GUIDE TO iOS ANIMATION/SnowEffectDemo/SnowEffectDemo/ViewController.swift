//
//  ViewController.swift
//  SnowEffectDemo
//
//  Created by feiyun on 16/8/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let snowEmitter = CAEmitterLayer()
        
        snowEmitter.emitterPosition = CGPointMake(self.view.bounds.width / 2, -30)
        snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width / 2.0, -30)
        snowEmitter.emitterShape = kCAEmitterLayerLine
        snowEmitter.emitterMode  = kCAEmitterLayerOutline
        
        let snowflake = CAEmitterCell()
        snowflake.birthRate	= 1.0
        snowflake.lifetime	= 120.0
        snowflake.velocity	= -10
        snowflake.velocityRange = 10
        snowflake.yAcceleration = 2
        snowflake.emissionRange = CGFloat(0.5 * M_PI)
        snowflake.spinRange = CGFloat(0.25 * M_PI)
        snowflake.contents = UIImage(named: "snow")?.CGImage
        snowflake.color = UIColor(red: 0.600, green: 0.658, blue: 0.743, alpha: 1.000).CGColor
        
        snowEmitter.shadowOpacity = 1.0
        snowEmitter.shadowRadius  = 0.0
        snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0)
        snowEmitter.shadowColor   = UIColor.whiteColor().CGColor
        
        snowEmitter.emitterCells = Array(arrayLiteral: snowflake)
        view.layer.insertSublayer(snowEmitter, atIndex: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

