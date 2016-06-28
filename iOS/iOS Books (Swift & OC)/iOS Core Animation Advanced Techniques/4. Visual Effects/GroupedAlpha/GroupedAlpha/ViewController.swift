//
//  ViewController.swift
//  GroupedAlpha
//
//  Created by feiyun on 16/6/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create opaque button
        let button1 = self.customButton()
        button1.center = CGPointMake(50, 150);
        self.containerView.addSubview(button1)
        
        //create translucent button
        
        let button2 = self.customButton()
        button2.center = CGPointMake(250, 150);
        button2.alpha = 0.5;
        self.containerView.addSubview(button2)
        button2.layer.shouldRasterize = true
        button2.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        
        let button3 = self.customButton()
        button3.center = CGPointMake(150, 250);
        button3.alpha = 0.5;
        self.containerView.addSubview(button3)
        
        
    }

    func customButton() -> UIButton {
        //create button
        var frame = CGRectMake(0, 0, 150, 50);
        let button = UIButton.init(frame: frame)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 10;
        
        //add label
        frame = CGRectMake(20, 10, 110, 30);
        let label = UILabel.init(frame: frame)
        label.text = "Hello World";
        label.textAlignment = .Center;
        button.addSubview(label)
        return button;

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

