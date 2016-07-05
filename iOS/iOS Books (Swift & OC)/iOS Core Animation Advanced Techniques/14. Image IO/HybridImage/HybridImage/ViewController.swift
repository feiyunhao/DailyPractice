//
//  ViewController.swift
//  HybridImage
//
//  Created by feiyun on 16/7/5.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "Snowman.jpg")
        let mask = UIImage(named: "SnowmanMask.png")
        
        let graySpace = CGColorSpaceCreateDeviceGray()
        let maskRef = CGImageCreateCopyWithColorSpace(mask?.CGImage, graySpace)
        
        let resultRef = CGImageCreateWithMask(image?.CGImage, maskRef)
        let result = UIImage(CGImage:resultRef!)
        
        self.imageView.image = result
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

