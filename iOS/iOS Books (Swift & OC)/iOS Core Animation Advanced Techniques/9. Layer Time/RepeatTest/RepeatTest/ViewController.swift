//
//  ViewController.swift
//  RepeatTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    let shipLayer = CALayer()
    
    @IBAction func start(sender: AnyObject) {
        
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
        self.shipLayer.position = CGPointMake(150, 150);
        self.shipLayer.contents = UIImage(named:"Spaceship")!.CGImage;
        self.containerView.layer.addSublayer(self.shipLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

