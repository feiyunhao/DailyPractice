//
//  ViewController.swift
//  SpotifyVideoBackground
//
//  Created by feiyun on 16/5/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: VoideSplashViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView().image =  UIImage(contentsOfFile:"/Users/feiyun/Desktop/login-secondary-logo")!
        setupVideoBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupVideoBackground() {
        
        let url = NSURL.fileURLWithPath("/Users/feiyun/Desktop/moments.mp4")
        
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.userInteractionEnabled = false
        
    }
}

