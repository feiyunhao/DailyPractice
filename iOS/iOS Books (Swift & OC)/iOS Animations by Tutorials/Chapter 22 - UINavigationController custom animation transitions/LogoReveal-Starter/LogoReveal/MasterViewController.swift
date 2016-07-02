//
//  ViewController.swift
//  LogoReveal
//
//  Created by feiyun on 16/6/30.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTouch))
        
        self.view.addGestureRecognizer(tap)
    }
    
    func didTouch() -> () {
        performSegueWithIdentifier("details", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

