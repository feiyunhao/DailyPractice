//
//  ViewController.swift
//  TimeConsuming
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activity: UIActivityIndicatorView!

    @IBAction func doSomeThing(sender: UIButton) {
        sender.enabled = false
        activity.startAnimating()
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) { 
            sleep(3)
            dispatch_async(dispatch_get_main_queue(), { 
                self.activity.stopAnimating()
                sender.enabled = true
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

