//
//  CAReplicatorLayerTest.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CAReplicatorLayerTest: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let replicator = CAReplicatorLayer()
        replicator.frame = self.containerView.frame
        self.containerView.layer.addSublayer(replicator)
        
        replicator.instanceCount = 10
        
        var transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, 0, 10, 0);
        transform = CATransform3DRotate(transform, CGFloat(M_PI / 10.0), 0, 0, 1);
        transform = CATransform3DTranslate(transform, 0,  10, 0);
        replicator.instanceTransform = transform;
        
        //apply a color shift for each instance
        replicator.instanceBlueOffset = -0.1;
        replicator.instanceGreenOffset = -0.1;
        
        let layer = CALayer()
        layer.frame = CGRectMake(10.0, 10.0, 10.0, 10.0);
        layer.backgroundColor = UIColor.whiteColor().CGColor
        replicator.addSublayer(layer)
        
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
