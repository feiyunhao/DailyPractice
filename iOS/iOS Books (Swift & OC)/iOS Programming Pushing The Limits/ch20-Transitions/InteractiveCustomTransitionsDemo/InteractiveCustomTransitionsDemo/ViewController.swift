//
//  ViewController.swift
//  InteractiveCustomTransitionsDemo
//
//  Created by feiyun on 16/7/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
     func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.startInteractiveTransition(transitionContext)
    }
    
    func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let src = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let centerPoint = src?.view.center
        
        UIView.animateWithDuration(1, animations: {
            src!.view.frame = CGRectMake(centerPoint!.x, centerPoint!.y, 10, 10);
            src!.view.center = centerPoint!
            
        }) { (Bool) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.animator
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
         return self.animator
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var animator: SCTPercentDrivenAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = SCTPercentDrivenAnimator(controller: (self as UIViewController))
        let gr = UIPinchGestureRecognizer.init(target: self.animator, action: #selector(SCTPercentDrivenAnimator.pinchGestureAction(_:)))
        self.view.addGestureRecognizer(gr)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        self.transitioningDelegate = self
    }
    
//    func pinchGestureAction(_:UIPinchGestureRecognizer) -> Void {
//        //????
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

