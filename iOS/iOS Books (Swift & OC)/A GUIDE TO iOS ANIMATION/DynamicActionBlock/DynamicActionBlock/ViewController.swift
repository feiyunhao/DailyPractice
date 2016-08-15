//
//  ViewController.swift
//  DynamicActionBlock
//
//  Created by feiyun on 16/8/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dynamicView = DynamicView(frame: view.bounds)
        view.addSubview(dynamicView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

