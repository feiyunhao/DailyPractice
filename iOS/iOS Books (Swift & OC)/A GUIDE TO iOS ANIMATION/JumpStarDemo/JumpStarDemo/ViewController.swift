//
//  ViewController.swift
//  JumpStarDemo
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jumpStarView: JumpStarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jumpStarView.layoutSubviews()
        let option = JumpStarOptions(markedImage: UIImage(named: "icon_star_incell")!, notMarkedImage: UIImage(named: "blue_dot")!, jumpDuration: 0.125, downDuration: 0.215)
        jumpStarView.option = option
        jumpStarView.state = .NotMarked
    }

    @IBAction func jumpButtonDidTapped(sender: AnyObject) {
        jumpStarView.animate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

