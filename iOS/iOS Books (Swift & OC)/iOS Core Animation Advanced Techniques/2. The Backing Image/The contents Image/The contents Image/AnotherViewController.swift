//
//  AnotherViewController.swift
//  The contents Image
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    func addSpriteImage(image: UIImage,withContentRect rect: CGRect, toLayer layer:CALayer) -> () {
        layer.contents = image.CGImage
        layer.contentsGravity = kCAGravityResizeAspect

        //contentsRect
        layer.contentsRect = rect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(contentsOfFile:"/Users/feiyun/Desktop/2.7.png")
        
        for (index,item) in [view1, view2, view3, view4 ].enumerate() {
            self.addSpriteImage(image!,
                                withContentRect: [
                                    CGRectMake(0, 0, 0.5, 0.5),
                                    CGRectMake(0.5, 0, 0.5, 0.5),
                                    CGRectMake(0, 0.5, 0.5, 0.5),
                                    CGRectMake(0.5, 0.5, 0.5, 0.5)][index],
                                toLayer: item.layer)
        }
        
    }
}
