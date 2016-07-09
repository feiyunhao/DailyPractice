//
//  ViewController.swift
//  Dynamics
//
//  Created by feiyun on 16/7/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import QuartzCore

private let kInitialPoint1 = CGPointMake(200, 300)
private let kInitialPoint2 = CGPointMake(500, 300)


class ViewController: UIViewController {

    @IBOutlet weak var box1: UIView!
    @IBOutlet weak var box2: UIView!
    
    var dynamicAnimator:UIDynamicAnimator!
    
    @IBAction func reset(sender: AnyObject) {
        dynamicAnimator.removeAllBehaviors()
        self.box1.center = kInitialPoint1;
        self.box1.transform = CGAffineTransformIdentity;
        self.box2.center = kInitialPoint2;
        self.box2.transform = CGAffineTransformIdentity;
    }
    
    @IBAction func snap(sender: AnyObject) {
        let point = self.randomPoint()
        let snap = UISnapBehavior.init(item: box1, snapToPoint: point)
        snap.damping = 1
        dynamicAnimator.addBehavior(snap)
        self.addTemporaryBehavior(snap)
    }
    
    @IBAction func attach(sender: AnyObject) {
        let attach1 = UIAttachmentBehavior.init(item: box1, offsetFromCenter: UIOffsetMake(25, 25), attachedToAnchor: box1.center)
        dynamicAnimator.addBehavior(attach1)
        let attach2 = UIAttachmentBehavior.init(item: box2, attachedToItem: box1)
        dynamicAnimator.addBehavior(attach2)
        let push = UIPushBehavior.init(items: [box2], mode: .Instantaneous)
        push.pushDirection = CGVectorMake(0, 2)
        dynamicAnimator.addBehavior(push)
    }
    
    @IBAction func push(sender: AnyObject) {
        let push = UIPushBehavior.init(items: [box1], mode: .Continuous)
        push.pushDirection = CGVector.init(dx: 1, dy: 0)
        dynamicAnimator.addBehavior(push)
    }
    
    @IBAction func gravity(sender: AnyObject) {
        let gravity = UIGravityBehavior.init(items: [box1, box2])
        gravity.action = {
            print(self.box1.center)
        }
        dynamicAnimator.addBehavior(gravity)
    }
    
    @IBAction func collision(sender: AnyObject) {
        let collision = UICollisionBehavior.init(items: [box1,box2])
        dynamicAnimator.addBehavior(collision)
        let push = UIPushBehavior.init(items: [box1], mode: .Instantaneous)
        push.pushDirection = CGVectorMake(10, 0)
        self.addTemporaryBehavior(push)
    }
    
    func randomPoint() -> CGPoint {
        let size = self.view.bounds.size
        return CGPointMake(CGFloat(arc4random_uniform(UInt32(size.width))),
                           CGFloat(arc4random_uniform(UInt32(size.height))))
    }
    
    func addTemporaryBehavior(behavior: UIDynamicBehavior) {
        dynamicAnimator.addBehavior(behavior)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.dynamicAnimator.removeBehavior(behavior)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dynamicAnimator = UIDynamicAnimator.init(referenceView: self.view)
        self.reset("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

