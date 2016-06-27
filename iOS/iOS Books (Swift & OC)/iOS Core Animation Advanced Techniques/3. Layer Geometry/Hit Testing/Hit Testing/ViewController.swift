//
//  ViewController.swift
//  Hit Testing
//
//  Created by feiyun on 16/6/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layerView: UIView!
    let blueLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blueLayer.backgroundColor = UIColor.blueColor().CGColor
        blueLayer.frame = CGRectMake(50, 50, 100, 100)
        layerView.layer.addSublayer(blueLayer)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let point = touches.first?.locationInView(self.view)
        
        //它返回图层本身，或者包含这个坐标点的叶子节点图层。这意味着不再需要像使用-containsPoint:那样，人工地在每个子图层变换或者测试点击的坐标
        let hitedLayer = self.layerView.layer.hitTest(point!)
        
        let action = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        if hitedLayer == blueLayer {
            let alert = UIAlertController.init(title: "Inside Blue Layer", message: nil, preferredStyle: .Alert)
            alert.addAction(action)
            self.showViewController(alert, sender: nil)
        } else if hitedLayer == self.layerView.layer {
            let alert = UIAlertController.init(title: "Inside White Layer", message: nil, preferredStyle: .Alert)
            alert.addAction(action)
            self.showViewController(alert, sender: nil)
        }
        
        
    
        /*
        
        //定义在一个图层坐标系下的点或者矩形转换成另一个图层坐标系下的点或者矩形
        point = self.layerView.layer.convertPoint(point!, fromLayer: self.view.layer)
        
        //containsPoint 接受一个在本图层坐标系下的CGPoint，如果这个点在图层frame范围内就返回YES
        if self.layerView.layer.containsPoint(point!) {
            point = self.blueLayer.convertPoint(point!, fromLayer: self.layerView.layer)
            let action = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
            if self.blueLayer.containsPoint(point!) {
                let alert = UIAlertController.init(title: "Inside Blue Layer", message: nil, preferredStyle: .Alert)
                alert.addAction(action)
                self.showViewController(alert, sender: nil)
            } else {
                let alert = UIAlertController.init(title: "Inside White Layer", message: nil, preferredStyle: .Alert)
                alert.addAction(action)
                self.showViewController(alert, sender: nil)
            }
        }
 
         */
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

