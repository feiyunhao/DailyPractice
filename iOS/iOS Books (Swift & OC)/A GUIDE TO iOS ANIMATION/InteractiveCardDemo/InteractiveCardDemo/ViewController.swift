//
//  ViewController.swift
//  InteractiveCardDemo
//
//  Created by feiyun on 16/8/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var option = InteractiveOptions()
        option.damping = 0.7
        option.duration = 0.5
        option.scrollDistance = 200.0
        
        let interactiveView = InteractiveView(image: UIImage(named: "pic01"), option: option)
        interactiveView.center = view.center
        interactiveView.bounds = CGRectMake(0, 0, 200, 150)
        interactiveView.gestureView = view
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blurView.frame = view.bounds
        view.addSubview(blurView)
        interactiveView.dimmingView = blurView
        
        let backView = UIView(frame: view.bounds)
        view.addSubview(backView)
        backView.addSubview(interactiveView)

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

