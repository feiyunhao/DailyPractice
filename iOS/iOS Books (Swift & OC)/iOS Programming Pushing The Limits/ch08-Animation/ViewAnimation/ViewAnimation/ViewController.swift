//
//  ViewController.swift
//  ViewAnimation
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let circleView = UIView(frame:CGRectMake(0, 0, 20, 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circleView.center = CGPoint(x: 100, y: 40)
        circleView.backgroundColor = UIColor.redColor()
        self.view.addSubview(circleView)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dropAnimation(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func dropAnimation(recognizer:UITapGestureRecognizer) -> () {
        UIView.animateWithDuration(3, animations: { 
            recognizer.enabled = false
            self.circleView.center = CGPoint(x: 100, y: 300)
        }) { (finshed:Bool) in
                UIView.animateWithDuration(1, animations: {
                    self.circleView.center = CGPointMake(250, 300)
                    }, completion: { (finished:Bool) in
                        recognizer.enabled = true
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

