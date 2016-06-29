//
//  CAShapeLayer.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/6/29.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CAShapeLayerTest: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let path = UIBezierPath()
        
        path.addArcWithCenter(CGPointMake(150, 100), radius: 25, startAngle: 0, endAngle:CGFloat(2*M_PI), clockwise: true)
        
        path.moveToPoint(CGPointMake(150, 125))
        path.addLineToPoint(CGPointMake(150, 175))
        path.addLineToPoint(CGPointMake(125, 225))
        
        path.moveToPoint(CGPointMake(150, 175))
        path.addLineToPoint(CGPointMake(175, 225))
        
        path.moveToPoint(CGPointMake(100, 150))
        path.addLineToPoint(CGPointMake(200, 150))
        
        path.moveToPoint(CGPointMake(135, 100))
        path.addLineToPoint(CGPointMake(140, 100))
        
        path.moveToPoint(CGPointMake(165, 100))
        path.addLineToPoint(CGPointMake(160, 100))
        
        path.moveToPoint(CGPointMake(100, 120))
        path.addArcWithCenter(CGPointMake(150, 115), radius: 5, startAngle: CGFloat(-M_PI_4), endAngle: CGFloat(-M_PI_4*3), clockwise: true)

        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineWidth = 5
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        self.containerView.layer.addSublayer(layer)
        
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
