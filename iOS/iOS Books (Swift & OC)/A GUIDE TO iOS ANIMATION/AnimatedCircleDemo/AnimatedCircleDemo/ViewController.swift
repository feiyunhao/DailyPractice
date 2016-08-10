//
//  ViewController.swift
//  AnimatedCircleDemo
//
//  Created by feiyun on 16/8/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    private var circleView: CircleView!
    
    @IBAction func didValueChanged(sender: UISlider) {
        progressLabel.text = "Current: \(slider.value)"
        circleView.circleLayer.progress = CGFloat(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView = CircleView(frame: CGRectMake(view.frame.size.width/2 - 320/2, view.frame.size.height/2 - 320/2, 320, 320))
        view.addSubview(circleView)
        circleView.circleLayer.progress = CGFloat(slider.value)
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

