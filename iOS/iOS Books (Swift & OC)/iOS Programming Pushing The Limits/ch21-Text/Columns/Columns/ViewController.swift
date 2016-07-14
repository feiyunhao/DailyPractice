//
//  ViewController.swift
//  Columns
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let kLipsum = try? String.init(contentsOfFile: NSBundle.mainBundle().pathForResource("sample", ofType: "txt")!, encoding: NSUTF8StringEncoding)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

