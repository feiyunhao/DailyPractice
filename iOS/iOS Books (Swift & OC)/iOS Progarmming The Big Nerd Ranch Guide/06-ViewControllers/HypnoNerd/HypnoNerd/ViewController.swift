//
//  ViewController.swift
//  HypnoNerd
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarItem.title = "hehe"
    }

    
    override func loadView() {
        let backgroundView = Hypnosister(frame: UIScreen.mainScreen().bounds)
        self.view = backgroundView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

