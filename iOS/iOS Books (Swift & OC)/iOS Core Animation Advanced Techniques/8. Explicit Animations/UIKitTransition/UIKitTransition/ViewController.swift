//
//  ViewController.swift
//  UIKitTransition
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
        
        UIView.transitionWithView(self.imageView, duration: 1, options: .TransitionFlipFromLeft, animations: { 
            [weak self] in
            
            self?.imageView.image = self!.images[self!.index++ % self!.images.count] as? UIImage
            
            }, completion: nil)
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

