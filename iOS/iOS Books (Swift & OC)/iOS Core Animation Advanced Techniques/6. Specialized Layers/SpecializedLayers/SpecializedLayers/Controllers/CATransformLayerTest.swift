//
//  CATransformLayerTest.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/7/1.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CATransformLayerTest: UIViewController {
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pt = CATransform3DIdentity
        pt.m34 = -1.0 / 500
        self.containerView.layer.sublayerTransform = pt
        
        var c1t = CATransform3DIdentity
        c1t = CATransform3DTranslate(c1t, -100, 0, 0)
        let layer1 = self.cubeWithTransform(c1t)
        self.containerView.layer.addSublayer(layer1)
        
        var c2t = CATransform3DIdentity
        c2t = CATransform3DTranslate(c2t, 100, 0, 0)
        c2t = CATransform3DRotate(c2t, CGFloat(-M_PI_4), 1, 0, 0)
        c2t = CATransform3DRotate(c2t, CGFloat(-M_PI_4), 0, 1, 0)
        let layer2 = self.cubeWithTransform(c2t)
        self.containerView.layer.addSublayer(layer2)
    }
    
    func cubeWithTransform(transform: CATransform3D) -> CALayer {
        
        /// CATransformLayer
        let cube = CATransformLayer()
        
        var ct = CATransform3DMakeTranslation(0, 0, 50)
        cube.addSublayer(self.faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 0, 1, 0)
        cube.addSublayer(self.faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(0, -50, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 1, 0, 0)
        cube.addSublayer(self.faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(0, 50, 0)
        ct = CATransform3DRotate(ct, CGFloat(-M_PI_2), 1, 0, 0)
        cube.addSublayer(self.faceWithTransform(ct))

        ct = CATransform3DMakeTranslation(-50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(-M_PI_2), 0, 1, 0)
        cube.addSublayer(self.faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(0, 0, -50)
        ct = CATransform3DRotate(ct, CGFloat(M_PI), 0, 1, 0)
        cube.addSublayer(self.faceWithTransform(ct))
        
        let containerSize = self.containerView.bounds.size
        cube.position = CGPointMake(containerSize.width / 2.0,
                                    containerSize.height / 2.0)
        cube.transform = transform
        return cube
    }
    
    func faceWithTransform(transform: CATransform3D) -> CALayer {
        let face = CALayer()
        face.frame = CGRectMake(-50, -50, 100, 100)
        let red = CGFloat(rand())/CGFloat(Int32.max)
        let green = CGFloat(rand())/CGFloat(Int32.max)
        let blue = CGFloat(rand())/CGFloat(Int32.max)
        face.backgroundColor = UIColor(red: red, green: green, blue: blue,alpha: 1).CGColor
        face.transform = transform
        return face
        
    }
}
