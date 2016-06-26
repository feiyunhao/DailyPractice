//
//  MenuTransitionManager.swift
//  SliderMenu
//
//  Created by feiyun on 16/5/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate{
    
    func dismiss()
}

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

   
    var duration = 0.5
    var isPresenting = false
    var delegate: MenuTransitionManagerDelegate?
    
    /// 当赋值了截屏后，给截屏添加手势，让代理调用dismiss方法
    var snapshot:UIView? {
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action:#selector(_delegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    //一个是动画效果的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
         print("transitionDuration")
        return duration
    }
    func animationEnded(transitionCompleted: Bool) {
         print("animationEnded")
    }
    //动画效果
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("animateTransition")
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let container = transitionContext.containerView()
        
//        print(fromView,"\n\n",toView,"\n\n",container)
        
        let moveDown = CGAffineTransformMakeTranslation(0, container!.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        print(isPresenting)
        if isPresenting {
            toView.transform = moveUp
            //截屏
            snapshot = UIView(frame: CGRect(x: 0 , y: 0 ,width: 414, height: 732))
            //fromView?.snapshotViewAfterScreenUpdates(true)
            snapshot?.backgroundColor = UIColor.redColor()
            container!.addSubview(toView)
            container!.addSubview(snapshot!)
            
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: { 
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransformIdentity
            } else {
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView!.transform = moveUp
            }
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
//                if !self.isPresenting {
//                    self.snapshot?.removeFromSuperview()
//                }
        })
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationControllerForDismissedController")
        print(dismissed)
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationControllerForPresentedController")
        print(presented,presenting,source)

        isPresenting = true
        return self
    }
    
}
