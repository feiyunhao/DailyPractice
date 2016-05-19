//
//  MenuTransitionManager.swift
//  TumblrMenu
//
//  Created by feiyun on 16/5/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    
    private var presenting = false

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let screens : (from: UIViewController, to: UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        if (self.presenting) {
            
            self.offStageMenuController(menuViewController)
            
        }
        
        container!.addSubview(bottomView)
        container!.addSubview(menuView)

        let duration = self.transitionDuration(transitionContext)

        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                
                self.onStageMenuController(menuViewController)
                
            } else {
                
                self.offStageMenuController(menuViewController)
                
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(screens.to.view)
                
        })

        
        
    }
    
    func offStageMenuController(menuViewController: MenuViewController) {
        
        menuViewController.view.alpha = 0
        
        let topRowOffset  : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let bottomRowOffset  : CGFloat = 50
        
        menuViewController.Btn11.transform = self.offstage(-topRowOffset)
        
        
        menuViewController.Btn12.transform = self.offstage(topRowOffset)
      
        
        menuViewController.Btn21.transform = self.offstage(-middleRowOffset)
       
        
        menuViewController.Btn22.transform = self.offstage(middleRowOffset)
       
        
        menuViewController.Btn31.transform = self.offstage(-bottomRowOffset)
       
        
        menuViewController.Btn32.transform = self.offstage(bottomRowOffset)
       
        
    }
    func offstage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    func onStageMenuController(menuViewController: MenuViewController) {
        
        
        menuViewController.view.alpha = 1
        
        menuViewController.Btn11.transform = CGAffineTransformIdentity
        menuViewController.Btn12.transform = CGAffineTransformIdentity
        menuViewController.Btn21.transform = CGAffineTransformIdentity
        menuViewController.Btn22.transform = CGAffineTransformIdentity
        menuViewController.Btn31.transform = CGAffineTransformIdentity
        menuViewController.Btn32.transform = CGAffineTransformIdentity
        
    }
    

    
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = false
        return self
    }

    
}
