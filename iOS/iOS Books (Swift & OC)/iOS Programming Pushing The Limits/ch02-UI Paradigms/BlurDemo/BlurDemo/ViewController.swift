//
//  ViewController.swift
//  BlurDemo
//
//  Created by feiyun on 16/6/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var layer: CALayer!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBAction func buttonAction(sender: AnyObject) {
        
        //创建涂层
        layer = CALayer()
        layer.frame = bgImageView.frame
        self.view.layer.addSublayer(layer)
        
        //截屏
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, scale)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: false)
        //从当前上下文中获取一个UIImage对象
        var image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //裁剪截图
        let imageRef = CGImageCreateWithImageInRect(image.CGImage,
                                                    CGRectMake(self.layer.frame.origin.x * scale,
                                                        self.layer.frame.origin.y * scale,
                                                        self.layer.frame.size.width * scale,
                                                        self.layer.frame.size.height * scale))
        image = UIImage(CGImage:imageRef!)
        
        //添加效果
        image = image.applyLightEffect()
        
        //放到新建的图层上
        layer.contents = image.CGImage
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

extension UIImage {
    
}