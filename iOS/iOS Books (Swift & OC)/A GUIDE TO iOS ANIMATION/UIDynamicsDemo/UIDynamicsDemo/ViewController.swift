//
//  ViewController.swift
//  UIDynamicsDemo
//
//  Created by feiyun on 16/8/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var lockScreenView: UIImageView!
    private var animator: UIDynamicAnimator!
    private var gravityBehaviour: UIGravityBehavior!
    private var pushBehavior: UIPushBehavior!
    private var attachmentBehaviour: UIAttachmentBehavior!
    private var itemBehaviour: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockScreenView = UIImageView(frame: view.bounds)
        lockScreenView.backgroundColor = UIColor.cyanColor()
        lockScreenView.contentMode = .ScaleToFill
        lockScreenView.userInteractionEnabled = true
        view.addSubview(lockScreenView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnIt(_:)))
        lockScreenView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panOnIt(_:)))
        lockScreenView.addGestureRecognizer(panGesture)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        animator = UIDynamicAnimator(referenceView: view)
        let collisionBehiver = UICollisionBehavior(items:[lockScreenView])
        //用来设置碰撞边界。
        collisionBehiver.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsets(top: -lockScreenView.frame.height, left: 0, bottom: 0, right: 0))
        animator.addBehavior(collisionBehiver)
        
        
        gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
        //重力方向
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        //“表示震级。越大加速度越大，下落越快。”
        gravityBehaviour.magnitude = 2.6
        //“表示偏移的角度。弧度制。和 gravityDirection 的作用一致。”
//        gravityBehaviour.angle = CGFloat(M_PI)
        animator.addBehavior(gravityBehaviour)
        
        pushBehavior = UIPushBehavior(items: [lockScreenView], mode: .Instantaneous)
        pushBehavior.magnitude = 2
        pushBehavior.angle = CGFloat(M_PI)
        animator.addBehavior(pushBehavior)
        
        itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
//        撞系数 elasticity，1.0 表示完全弹性碰撞，也就是碰撞时没有动能损失，碰撞之后一直在做运动（或者需要很久才能恢复静止）”
        itemBehaviour.elasticity = 0.35
        animator.addBehavior(itemBehaviour)
        
    }
    
    @objc private func tapOnIt(tapGes: UITapGestureRecognizer) {
        pushBehavior.pushDirection = CGVector(dx: 0.0, dy: -80.0)
        pushBehavior.active = true
    }
    
    @objc private func panOnIt(panGes: UIPanGestureRecognizer) {
        let location = CGPoint(x: CGRectGetMidX(lockScreenView.frame), y: panGes.locationInView(view).y)
        if panGes.state == .Began {
            animator.removeBehavior(gravityBehaviour)
            attachmentBehaviour = UIAttachmentBehavior(item: lockScreenView, attachedToAnchor: location)
            animator.addBehavior(attachmentBehaviour)
        } else if panGes.state == .Changed {
            attachmentBehaviour.anchorPoint = location
        } else if panGes.state == .Ended {
            let velocity = panGes.velocityInView(lockScreenView)
            animator.removeBehavior(attachmentBehaviour)
            attachmentBehaviour = nil
            print(velocity.y)
            print(panGes.locationInView(view).y)
            if velocity.y < -1300 {
                animator.removeBehavior(gravityBehaviour)
                animator.removeBehavior(itemBehaviour)
                gravityBehaviour = nil
                itemBehaviour = nil
                
                //gravity
                gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
                gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: -1.0)
                gravityBehaviour.magnitude = 2.6
                animator.addBehavior(gravityBehaviour)
                
                //item
                itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
                itemBehaviour.elasticity = 0.0
                animator.addBehavior(itemBehaviour)
                
                //push
                pushBehavior.pushDirection = CGVector(dx: 0.0, dy: -200.0)
                pushBehavior.active = true
            }else {
                restore("")
            }
        }
        
    }

    @IBAction func restore(sender: AnyObject) {
        
        animator.removeBehavior(gravityBehaviour)
        animator.removeBehavior(itemBehaviour)
        gravityBehaviour = nil
        itemBehaviour  = nil
        
        //gravity
        gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        gravityBehaviour.magnitude = 2.6
        
        //item
        itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
        itemBehaviour.elasticity = 0.35
        animator.addBehavior(itemBehaviour)
        animator.addBehavior(gravityBehaviour)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

