//
//  ViewController.swift
//  InteractiveCardDemo
//
//  Created by feiyun on 16/8/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var option = InteractiveOptions()
        option.damping = 0.7
        option.duration = 0.5
        option.scrollDistance = 200.0
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

