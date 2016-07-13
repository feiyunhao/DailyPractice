//
//  ViewController.swift
//  ScribbleLayout
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "txt")!
        let string = try? String.init(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        let attributedString = NSMutableAttributedString.init(string: string!)
        let style = NSMutableParagraphStyle()
        style.alignment = .Justified
        
        let text = PTLScribbleTextStorage()
        text.tokens = [
            "France"    : [ NSForegroundColorAttributeName  : UIColor.blueColor() ],
            "England"   : [ NSForegroundColorAttributeName  : UIColor.redColor()],
            "season"    : [PTLRedactStyleAttributeName      : true ],
            "and"       : [PTLHighlightColorAttributeName   : UIColor.yellowColor() ],
            PTLDefaultTokenName : [
                NSParagraphStyleAttributeName: style,
                NSFontAttributeName          : UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
            ]
        ]
        text.setAttributedString(attributedString)
        
        let layoutManger = PTLScribbleLayoutManager()
        text.addLayoutManager(layoutManger)
        
        let textFrame = CGRectMake(30, 40, 708, 400)
        let textContainer = NSTextContainer.init(size: textFrame.size)
        layoutManger.addTextContainer(textContainer)
        
        let textView = UITextView.init(frame: textFrame, textContainer: textContainer)
        self.view.addSubview(textView)
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

