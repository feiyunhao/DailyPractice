//
//  ViewController.swift
//  KYGooeyMenu
//
//  Created by feiyun on 16/8/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menu = Menu(frame: CGRectMake(view.center.x-50, view.frame.size.height - 200, 100, 100))
        view.addSubview(menu!)
    }

    @IBAction func showDedug(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

