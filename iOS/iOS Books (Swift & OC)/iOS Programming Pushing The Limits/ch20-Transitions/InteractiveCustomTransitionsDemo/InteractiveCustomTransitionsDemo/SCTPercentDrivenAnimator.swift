//
//  SCTPercentDrivenAnimator.swift
//  InteractiveCustomTransitionsDemo
//
//  Created by feiyun on 16/7/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class SCTPercentDrivenAnimator: UIPercentDrivenInteractiveTransition {
    var controller: UIViewController!
    
    
    init(controller: UIViewController) {
        self.controller = controller
        super.init()
    }
    
    var startScale:CGFloat = 0
    
    
    func pinchGestureAction(gestureRecognizer: UIPinchGestureRecognizer) {
        
        let scale = gestureRecognizer.scale
        if gestureRecognizer.state == .Began {
            
            self.startScale = scale;
            self.controller.dismissViewControllerAnimated(true, completion: nil)
        }
        if gestureRecognizer.state == .Changed {
            
            let completePercent = 1.0 - (scale/self.startScale);
            self.updateInteractiveTransition(completePercent)
        }
        if gestureRecognizer.state == .Ended {
            
            if gestureRecognizer.velocity >= 0 {
                self.cancelInteractiveTransition()
            }
            else {
                 self.finishInteractiveTransition()
            }
           
        }
        
        if gestureRecognizer.state == .Cancelled {
            
            self.cancelInteractiveTransition()
        }

    }
}
