//
//  ViewController.swift
//  ProgressReport
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func go(sender: AnyObject) {
        
        let source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue())
        var totalComplete: UInt = 0
        dispatch_source_set_event_handler(source) { 
            let value = dispatch_source_get_data(source)
            totalComplete += value
            self.progressView.progress = Float(totalComplete)/100.0
        }
        dispatch_resume(source)
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) { 
            for _ in 1...100{
                dispatch_source_merge_data(source, 1)
                usleep(20000)
            }
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

