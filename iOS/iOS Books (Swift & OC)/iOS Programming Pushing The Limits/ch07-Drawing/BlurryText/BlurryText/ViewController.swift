//
//  ViewController.swift
//  BlurryText
//
//  Created by feiyun on 16/6/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func toggleBlur(sender: AnyObject) {
        
        var frame = label.frame
//        floor 向下舍入，即取不大于x的最大整数
        if (frame.origin.x == floor(frame.origin.x)) {
            frame.origin.x += 0.25;
        }
        else {
            frame.origin.x = CGFloat(floor(Float(frame.origin.x)));
        }
        self.label.frame = frame;
        
        
    }
    
//    override func shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
//        return toInterfaceOrientation == .PortraitUpsideDown
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

