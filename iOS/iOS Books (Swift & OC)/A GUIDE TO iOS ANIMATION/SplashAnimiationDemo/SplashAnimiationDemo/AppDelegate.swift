//
//  AppDelegate.swift
//  SplashAnimiationDemo
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor(red: 128.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return true
        }
        window?.rootViewController = navigationController
        
        let maskLayer = CALayer()
        maskLayer.contents = UIImage(named: "logo")?.CGImage
        maskLayer.position = navigationController.view.center
        maskLayer.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        navigationController.view.layer.mask = maskLayer
        
        let maskBackgroundView = UIView(frame: navigationController.view.bounds)
        maskBackgroundView.backgroundColor = UIColor.whiteColor()
        navigationController.view.addSubview(maskBackgroundView)
        navigationController.view.bringSubviewToFront(maskBackgroundView)
        
        let logoMaskAnimation = CAKeyframeAnimation(keyPath: "bounds")
        logoMaskAnimation.duration = 1
        logoMaskAnimation.beginTime = CACurrentMediaTime() + 1
        
        let initalBounds = maskLayer.bounds
        let secondBounds = CGRectMake(0, 0, 50, 50)
        let finalBounds  = CGRectMake(0, 0, 2000, 2000)

        logoMaskAnimation.values = [NSValue(CGRect: initalBounds), NSValue(CGRect: secondBounds), NSValue(CGRect: finalBounds)]
        logoMaskAnimation.keyTimes = [0.0, 0.5, 1.0]
        logoMaskAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        logoMaskAnimation.removedOnCompletion = false
        logoMaskAnimation.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask?.addAnimation(logoMaskAnimation, forKey: "logoMaskAnimation")

        UIView.animateWithDuration(0.1, delay: 1.35, options: .CurveEaseIn, animations: { () -> Void in
            maskBackgroundView.alpha = 0.0
        }) { (finished) -> Void in
            maskBackgroundView.removeFromSuperview()
        }
        
        UIView.animateWithDuration(0.25, delay: 1.3, options: .TransitionNone, animations: { () -> Void in
            navigationController.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                navigationController.view.transform = CGAffineTransformIdentity
                }, completion: { (finished) -> Void in
                    navigationController.view.layer.mask = nil
            })
        }
        
        
        
        return true
    }

}

