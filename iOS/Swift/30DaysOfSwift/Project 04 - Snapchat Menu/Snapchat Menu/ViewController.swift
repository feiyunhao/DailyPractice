//
//  ViewController.swift
//  Snapchat Menu
//
//  Created by feiyun on 16/4/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = true
        let leftView: LeftView = LeftView(nibName: "LeftView",bundle: nil)
        let centerView :CameraView = CameraView(nibName: "CameraView",bundle: nil)
        let rigthView :RightView = RightView(nibName: "RightView",bundle: nil)
        self.addChildViewController(leftView)
        self.scrollView.addSubview(leftView.view)
        leftView.didMoveToParentViewController(self)
        
        self.addChildViewController(centerView)
        self.scrollView.addSubview(centerView.view)
        centerView.didMoveToParentViewController(self)
        
        self.addChildViewController(rigthView)
        self.scrollView.addSubview(rigthView.view)
        rigthView.didMoveToParentViewController(self)
        
//        
//        parent：父视图控制器，如果没有父视图控制器，将为nil
//        
//        当我们向我们的视图控制器容器（就是父视图控制器，它调用addChildViewController方法加入子视图控制器，它就成为了视图控制器的容器）中添加（或者删除）子视图控制器后，必须调用该方法，告诉iOS，已经完成添加（或删除）子控制器的操作。
        var centerViewFrame: CGRect = centerView.view.frame
        centerViewFrame.origin.x = self.view.frame.width
        centerView.view.frame = centerViewFrame
        
        var rightViewFrame: CGRect = rigthView.view.frame
        rightViewFrame.origin.x = 2 * self.view.frame.width
        rigthView.view.frame = rightViewFrame
        
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.size.height)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

