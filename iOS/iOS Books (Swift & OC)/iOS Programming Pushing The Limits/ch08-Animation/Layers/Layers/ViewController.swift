//
//  ViewController.swift
//  Layers
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "pushing")
        self.view.layer.contentsScale = UIScreen.mainScreen().scale
        print(self.view.layer.contentsScale)
        self.view.layer.contentsGravity = kCAGravityCenter
        self.view.layer.contents = image?.CGImage
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(performFlip(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func performFlip(recognizer: UITapGestureRecognizer) -> () {
        let delegateView = DelegateView(frame: self.view.frame)
        
        UIView.transitionFromView(self.view, toView: delegateView, duration: 1, options: .TransitionFlipFromRight, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

