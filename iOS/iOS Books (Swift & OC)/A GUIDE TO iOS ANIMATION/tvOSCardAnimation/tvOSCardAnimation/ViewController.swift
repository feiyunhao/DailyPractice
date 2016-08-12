//
//  ViewController.swift
//  tvOSCardAnimation
//
//  Created by feiyun on 16/8/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardView = TVOSCardView()
        cardView.center = view.center
        cardView.bounds = CGRect(x: 0, y: 0, width: 150, height: 200)
        view.addSubview(cardView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

