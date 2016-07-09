//
//  ViewController.swift
//  TearOff
//
//  Created by feiyun on 16/7/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

let kShapeDimension: CGFloat = 100.0
let kSliceCount: UInt = 6

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var defaultBehavior: DefaultBehavior?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        let frame = CGRectMake(0, 0,
                               kShapeDimension,
                               kShapeDimension)
        
        let dragView = DraggableView.init(frame: frame, animator: self.animator)
        dragView.center = CGPointMake(self.view.center.x / 4,
                                      self.view.center.y / 4)
        dragView.alpha = 0.5
        self.view.addSubview(dragView)
        
        let defaultBehavior = DefaultBehavior.init()
        //gravity collision
        self.animator.addBehavior(defaultBehavior)
        self.defaultBehavior = defaultBehavior
        
        let tearOffBehavior = TearOffBehavior.init(draggableView: dragView,
                                                   anchor: dragView.center) {
                                                    (tornView, newPinView) in
                                                    tornView.alpha = 1
                                                    defaultBehavior.addItem(tornView)
                                                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.trash(_:)))
                                                    tap.numberOfTapsRequired = 2
                                                    tornView.addGestureRecognizer(tap)
        }
        
        self.animator.addBehavior(tearOffBehavior)
    }

    func trash(g: UITapGestureRecognizer) {
        let view = g.view!
        let subviews = self.sliceView(view, intoRows: kSliceCount, columns: Int(kSliceCount))
        let trashAnimator = UIDynamicAnimator.init(referenceView: self.view)
        
        let defaultBehavior = DefaultBehavior()
        
        for subview in subviews {
            
            // Add the new "exploded" view to the hierarchy
            self.view.addSubview(subview)
            defaultBehavior.addItem(subview)
            
            // Create a push animation for each
            let push = UIPushBehavior.init(items: [subview], mode: .Instantaneous)
            push.pushDirection = (CGVectorMake(CGFloat(rand()/RAND_MAX) - 0.5,
            CGFloat(rand()/RAND_MAX) - 0.5))
            trashAnimator.addBehavior(push)
            // Fade out the pieces as they fly around.
            // At the end, remove them. Referencing trashAnimator here
            // also allows ARC to keep it around without an ivar.
            UIView.animateWithDuration(1, animations: { 
                subview.alpha = 1
                }, completion: { (completion) in
                    subview.removeFromSuperview()
                    trashAnimator.removeBehavior(push)
            })
        }
        
        self.defaultBehavior?.removeItem(view)
        view.removeFromSuperview()
    }
    
    
    func sliceView(view: UIView, intoRows rows: UInt, columns: Int) -> Array<UIImageView> {
        
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        let imageRef = UIGraphicsGetImageFromCurrentImageContext().CGImage
        UIGraphicsEndImageContext()
        
        var views = Array<UIImageView>()
        let width = CGFloat(CGImageGetWidth(imageRef))
        let height = CGFloat(CGImageGetHeight(imageRef))
        
        for row in 0..<rows
        {
            for column in 0..<columns {
                let rect = CGRectMake(
                                  CGFloat(column) * (width / CGFloat(columns)),
                                  CGFloat(row) * (height / CGFloat(rows)),
                                  CGFloat(width) / CGFloat(columns),
                                  CGFloat(height) / CGFloat(rows));
                let subImage = CGImageCreateWithImageInRect(imageRef, rect)
                let imageView = UIImageView.init(image: UIImage.init(CGImage: subImage!))
                
                imageView.frame = CGRectOffset(rect,
                                               CGRectGetMinX(view.frame),
                                               CGRectGetMinY(view.frame));
                views.append(imageView)
            }
        }
        
        return views
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

