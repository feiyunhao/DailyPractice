//
//  ViewController.swift
//  SolidObjects
//
//  Created by feiyun on 16/6/29.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import GLKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var faces: [UIView]!
    
    
    let LIGHT_DIRECTION  = (0, 1, -0.5)
    let AMBIENT_LIGHT = 0.5
    func applyLightingToLayer(face: CALayer) -> () {
//        GLKit 以后再看
        
        face.backgroundColor = UIColor(white: CGFloat(random()%256)/255.0, alpha:1).CGColor
        face.borderWidth = 1
        
    }
    
    func addFace(index: Int, transform: CATransform3D) -> () {
        let face = faces[index]

        self.containerView.addSubview(face)
        let containerSize = self.containerView.frame.size
        let center = CGPoint(x: containerSize.width/2, y:containerSize.height/2)
        face.center = center
        face.layer.transform = transform
        
        self.applyLightingToLayer(face.layer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1/500
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI_4), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(M_PI_2-M_PI_4), 0, 1, 0)
        self.containerView.layer.sublayerTransform = perspective
        
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        self.addFace(0, transform: transform)
        
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform,CGFloat(M_PI_2), 0, 1, 0)
        self.addFace(1, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform,CGFloat(M_PI_2), 1, 0, 0)
        self.addFace(2, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), -1, 0, 0)
        self.addFace(3, transform: transform)
        
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, -1, 0)
        self.addFace(4, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0)
        self.addFace(5, transform: transform)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
