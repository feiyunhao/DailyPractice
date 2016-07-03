//
//  CAGradientLayerTest.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CAGradientLayerTest: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gradient = CAGradientLayer()
        gradient.frame = self.containerView.frame
        gradient.colors = [UIColor.redColor().CGColor,
                           UIColor.yellowColor().CGColor,
                           UIColor.greenColor().CGColor]
        gradient.startPoint = CGPointZero
        gradient.endPoint = CGPointMake(1, 1)
//        gradient.locations = [0, 0.33, 0.66]
        self.containerView.layer.addSublayer(gradient)
        
        
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
