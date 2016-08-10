//
//  SecondViewController.swift
//  KYPingTransition
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var percentTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan(_:)))
        edgeGes.edges = .Left
        view.addGestureRecognizer(edgeGes)
        
    }
    
    func edgePan(recognizer: UIScreenEdgePanGestureRecognizer) {
        var per = recognizer.translationInView(view).x / view.bounds.size.width
        per = min(1.0, max(0.0, per))
        
        if recognizer.state == .Began {
            percentTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewControllerAnimated(true)
        } else if recognizer.state == .Changed {
            percentTransition?.updateInteractiveTransition(per)
        } else if recognizer.state == .Cancelled || recognizer.state == .Ended {
            if per > 0.3 {
                percentTransition?.finishInteractiveTransition()
            } else {
                percentTransition?.cancelInteractiveTransition()
            }
            percentTransition = nil
        }
    }
    
    @IBAction func FirstViewController(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SecondViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentTransition
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Pop {
            let pingInvert = PingInvertTransition()
            return pingInvert
        } else {
            return nil
        }
    }
}