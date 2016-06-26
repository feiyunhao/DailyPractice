//
//  OpacityViewController.swift
//  BasicAnimation
//
//  Created by feiyun on 16/5/24.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animateWithDuration(2, animations: {
            
            self.imageView.alpha = 0
            
        })
        // Do any additional setup after loading the view.
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
