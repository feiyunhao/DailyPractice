//
//  ViewController.swift
//  Hypnosister
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenRect = self.view.bounds
        var bigRect = screenRect
        bigRect.size.width *= 2
        
        let scrollView = UIScrollView(frame:screenRect)
        scrollView.pagingEnabled = true
        scrollView.contentSize = bigRect.size
        self.view.addSubview(scrollView)
        
        let hypnosisView = Hypnosister(frame:screenRect)
        scrollView.addSubview(hypnosisView)
        
        let anotherView = Hypnosister(frame:screenRect)
        anotherView.frame.origin.x = anotherView.frame.size.width
        scrollView.addSubview(anotherView)
        anotherView.circleColor = UIColor.redColor()
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

