//
//  ViewController.swift
//  ClipTest
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

//阴影通常就是在Layer的边界之外，如果你开启了masksToBounds属性，所有从图层中突出来的内容都会被才剪掉。
//右边用单独的视图把裁剪的视图包起来，我们就可以解决这个问题
//shadowOffset的默认值是 {0, -3}，意即阴影相对于Y轴有3个点的向上位移。
//shadowRadius属性控制着阴影的模糊度，当它的值是0的时候，阴影就和视图一样有一个非常确定的边界线。当值越来越大的时候，边界线看上去就会越来越模糊和自然。苹果自家的应用设计更偏向于自然的阴影，所以一个非零值再合适不过了。

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var layerView1: UIView!

    @IBOutlet weak var layerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set the corner radius on our layers
        self.layerView1.layer.cornerRadius = 20.0
        self.layerView2.layer.cornerRadius = 20.0
        
        //enable clipping on the second layer
        self.layerView2.layer.masksToBounds = true
        
        self.layerView1.layer.borderWidth = 5.0
        self.layerView2.layer.borderWidth = 5.0
        
        ///shadowColor，shadowOffset和shadowRadius
        //add a shadow to layerView1
        self.layerView1.layer.shadowOpacity = 0.5
        self.layerView1.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        self.layerView1.layer.shadowRadius = 5.0;
        
        //add same shadow to shadowView (not layerView2)
        self.layerView2.layer.shadowOpacity = 0.5;
        self.layerView2.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        self.layerView2.layer.shadowRadius = 5.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

