//
//  ScaleViewController.swift
//  BasicAnimation
//
//  Created by feiyun on 16/5/24.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var exampleView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

         self.exampleView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseIn, animations: { () -> Void in
            
            self.exampleView.transform = CGAffineTransformMakeScale(2, 2)
            self.exampleView.alpha = 1
            
            }, completion: nil )
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
