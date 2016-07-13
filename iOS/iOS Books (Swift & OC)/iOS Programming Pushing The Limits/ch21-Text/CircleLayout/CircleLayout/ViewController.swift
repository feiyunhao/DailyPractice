//
//  ViewController.swift
//  CircleLayout
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "txt")
        let string = try? String.init(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Justified
        
        //
        let textStorage = NSTextStorage.init(string: string!, attributes: [NSParagraphStyleAttributeName : style,
            NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
        
        //
        let layoutManger = NSLayoutManager()
        textStorage.addLayoutManager(layoutManger)
        
        let textViewFrame = CGRectMake(30, 40, 708, 708)
        let container = CircleTextContainer(size: textViewFrame.size)
        container.exclusionPaths = [UIBezierPath.init(ovalInRect: CGRectMake(425, 150, 150, 150))]
        //
        layoutManger.addTextContainer(container)
        
        let textView = UITextView.init(frame: textViewFrame, textContainer: container)
        textView.allowsEditingTextAttributes = true
        self.view.addSubview(textView)
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

