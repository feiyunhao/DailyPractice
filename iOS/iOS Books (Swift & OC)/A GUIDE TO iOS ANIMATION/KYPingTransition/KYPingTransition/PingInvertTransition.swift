//
//  PingInvertTransition.swift
//  KYPingTransition
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class PingInvertTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private var _transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        _transitionContext = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! SecondViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FirstViewController
        let containerView = transitionContext.containerView()
        
        let button = toVC.button
        
        let maskFinalPath = UIBezierPath(ovalInRect: button.frame)
        containerView?.addSubview(toVC.view)
        containerView?.addSubview(fromVC.view)
        
        var finalPoint = CGPoint()
        if button.frame.origin.x > toVC.view.bounds.size.width / 2 {
            if button.frame.origin.y < toVC.view.bounds.size.height / 2 {
                //NO.1
                finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds))
            } else {
                //NO.4
                finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0)
            }
        } else {
            if button.frame.origin.y < toVC.view.bounds.size.height / 2 {
                //NO.2
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds))
            } else {
                //NO.3
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0)
            }
        }
        
        let radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y))
        let maskStartPath = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskFinalPath.CGPath
        fromVC.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = maskStartPath.CGPath
        maskLayerAnimation.toValue  = maskFinalPath.CGPath
        maskLayerAnimation.duration = transitionDuration(transitionContext)
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
}

extension PingInvertTransition {
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = _transitionContext {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
            transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        }
    }
    
}
