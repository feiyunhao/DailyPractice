//
//  ViewController.swift
//  TransitionTest
//
//  Created by feiyun on 16/7/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let images:NSArray = [UIImage.init(named: "Anchor")!,
                  UIImage.init(named: "Cone")!,
                  UIImage.init(named: "Igloo")!,
                  UIImage.init(named: "Spaceship")!]
    var index = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func switchImage(sender: AnyObject) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        self.imageView.layer.addAnimation(transition, forKey: nil)
        self.imageView.image = self.images[index++ % self.images.count] as? UIImage
    }
        
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

