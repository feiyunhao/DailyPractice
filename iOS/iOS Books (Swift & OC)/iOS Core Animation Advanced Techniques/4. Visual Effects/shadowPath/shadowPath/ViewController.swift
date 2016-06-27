//
//  ViewController.swift
//  shadowPath
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var layerView1: UIView!
    @IBOutlet weak var layerView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //enable layer shadows
        
        self.layerView1.layer.shadowOpacity = 0.5
        self.layerView2.layer.shadowOpacity = 0.5
        
        //create a square shadow
        let squarePath = CGPathCreateMutable();
        CGPathAddRect(squarePath, nil, self.layerView1.bounds);
        self.layerView1.layer.shadowPath = squarePath;
        
        //create a circular shadow
        let circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath, nil, self.layerView2.bounds);
        self.layerView2.layer.shadowPath = circlePath;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

