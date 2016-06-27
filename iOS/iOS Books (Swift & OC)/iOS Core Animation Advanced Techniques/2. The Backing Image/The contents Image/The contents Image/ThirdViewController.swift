//
//  ThirdViewController.swift
//  The contents Image
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    func addStretchableImage(image: UIImage,withContentCenter rect: CGRect, toLayer layer:CALayer) -> () {
        layer.contents = image.CGImage
        //contentsCenter
//        layer.contentsCenter = rect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // contentsCenter
        self.addStretchableImage(UIImage(named: "snow")!, withContentCenter: CGRectMake(0.25, 0.25, 0.5, 0.5), toLayer: view1.layer)
        self.addStretchableImage(UIImage(named: "snow")!, withContentCenter: CGRectMake(0.25, 0.25, 0.5, 0.5), toLayer: view2.layer)
        
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
