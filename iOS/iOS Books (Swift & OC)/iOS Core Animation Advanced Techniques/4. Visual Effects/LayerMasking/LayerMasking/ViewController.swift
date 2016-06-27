//
//  ViewController.swift
//  LayerMasking
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let maskLayer = CALayer()
        let image = UIImage(named: "Cone")
        maskLayer.frame = self.imageView.bounds
        maskLayer.contents = image?.CGImage
        self.imageView.layer.mask = maskLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

