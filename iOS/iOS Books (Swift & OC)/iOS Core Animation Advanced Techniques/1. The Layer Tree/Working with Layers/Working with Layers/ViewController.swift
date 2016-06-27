//
//  ViewController.swift
//  Working with Layers
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var layerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layer = CALayer()
        layer.frame = CGRectMake(50, 50, 100, 100)
        
        
        layer.backgroundColor = UIColor.blueColor().CGColor
        self.layerView.layer.addSublayer(layer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

