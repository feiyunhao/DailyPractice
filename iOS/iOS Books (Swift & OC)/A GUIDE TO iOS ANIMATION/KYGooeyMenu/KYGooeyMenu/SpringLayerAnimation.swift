//
//  SpringLayerAnimation.swift
//  KYGooeyMenu
//
//  Created by feiyun on 16/8/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class SpringLayerAnimation: NSObject {
    
     static let sharedAnimation = SpringLayerAnimation()
    
    func createBasicAnimation(keypath: String, duration: Double, fromValue: AnyObject, toValue: AnyObject) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keypath)
        animation.values = basicAnimationValues(duration, fromValue: fromValue, toValue: toValue)
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        return animation
    }
}

extension SpringLayerAnimation {
    private func basicAnimationValues(duration: Double, fromValue: AnyObject, toValue: AnyObject) -> [Double] {
        let numberOfFrames = Int(duration * 60)
        var values = [Double](count: numberOfFrames, repeatedValue: 0.0)
        let diff = toValue.doubleValue - fromValue.doubleValue
        for frame in 0..<numberOfFrames {
            let x = Double(frame / numberOfFrames)
            let value = fromValue.doubleValue + diff * x
            values[frame] = value
        }
        return values
    }
}