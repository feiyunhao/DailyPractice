//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by feiyun on 16/5/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var Btn11: UIButton!
    
    @IBOutlet weak var Btn12: UIButton!
    
    
    @IBOutlet weak var Btn21: UIButton!
    
    @IBOutlet weak var Btn22: UIButton!
    
    @IBOutlet weak var Btn31: UIButton!
    
    @IBOutlet weak var Btn32: UIButton!
    
   let transitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.transitioningDelegate = self.transitionManager
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
