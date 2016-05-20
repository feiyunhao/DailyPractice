//
//  ViewController.swift
//  SliderOutMenu
//
//  Created by feiyun on 16/5/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        UIApplication.sharedApplication().statusBarHidden = true
        self.navigationController?.navigationBarHidden = true
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

