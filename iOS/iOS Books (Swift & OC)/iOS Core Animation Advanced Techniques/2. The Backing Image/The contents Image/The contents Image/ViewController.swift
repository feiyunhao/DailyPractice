//
//  ViewController.swift
//  The contents Image
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "snow")
        
        ///contents
        self.layerView.layer.contents = image?.CGImage
        
        //contentGravity
//        layerView.contentMode = .ScaleAspectFit
        layerView.layer.contentsGravity = kCAGravityCenter//kCAGravityResizeAspect
        
//        contentsScale 寄宿图的 像素尺寸 和 视图大小 的比例，默认情况下它是一个值为1.0的浮点数
//        layerView.layer.contentsScale = UIScreen.mainScreen().scale//CGFloat(image?.scale ?? 10)
        
        //maskToBounds
        layerView.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

