//
//  RotationViewController.swift
//  BasicAnimation
//
//  Created by feiyun on 16/5/24.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.spin()
        
    }
    
    func spin() {
        
        UIView.animateWithDuration(0.8, delay: 0, options: .CurveLinear, animations: {
            
            self.label.transform = CGAffineTransformRotate(self.label.transform, CGFloat(M_PI))
           
            
        }) { (finished) -> Void in
            self.spin()
        }
        
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
