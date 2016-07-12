//
//  ViewController.swift
//  Exclusion
//
//  Created by feiyun on 16/7/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "txt")
        let string = try? String.init(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        self.textView.text = string
        self.textView.textAlignment = .Justified
        
        let bounds = self.view.bounds
        let width = CGRectGetWidth(bounds)
        let hight = CGRectGetHeight(bounds)
        let rect = CGRectInset(bounds, width/4, hight/4)
        let exclusionPath = UIBezierPath.init(roundedRect: rect, cornerRadius: width/10)
        self.textView.textContainer.exclusionPaths = [exclusionPath]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

