//
//  ViewController.swift
//  SimpleLayout
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = CoreTextLabel(frame:CGRectInset(self.view.bounds,20,20))
        self.view.addSubview(label)

        
        let string: CFStringRef = "Here is some simple text that includes bold and italics.\n"+"\n"+"We can even include some color."
        
        let attrString:CFMutableAttributedStringRef = CFAttributedStringCreateMutable(nil, 0)
        CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), string)
        
        let baseFont: CTFontRef = CTFontCreateUIFontForLanguage(.User, 16, nil)!
        let length:CFIndex = CFStringGetLength(string)
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, length), kCTFontAttributeName, baseFont)
        
        let boldFont: CTFontRef = CTFontCreateCopyWithSymbolicTraits(baseFont, 0, nil, .BoldTrait, .BoldTrait)!
        CFAttributedStringSetAttribute(attrString, CFStringFind(string, "blod", .CompareCaseInsensitive), kCTFontAttributeName, boldFont)
        
        let italicFont: CTFontRef = CTFontCreateCopyWithSymbolicTraits(baseFont, 0, nil, .ItalicTrait, .ItalicTrait)!
        CFAttributedStringSetAttribute(attrString,  CFStringFind(string, "italics", .CompareCaseInsensitive), kCTFontAttributeName, italicFont)
        
        let color = UIColor.redColor().CGColor
        CFAttributedStringSetAttribute(attrString, CFStringFind(string, "color", .CompareCaseInsensitive), kCTForegroundColorAttributeName, color)
        var alignment:CTTextAlignment = .Center
        var setting:CTParagraphStyleSetting = CTParagraphStyleSetting.init(spec: .Alignment, valueSize: sizeofValue(alignment), value: &alignment)
        
        let style:CTParagraphStyleRef = CTParagraphStyleCreate(&setting, 1)
        var lastLineRange = CFStringFind(string, "\n", .CompareBackwards)
        
        lastLineRange.location += 1
        lastLineRange.length = CFStringGetLength(string) - lastLineRange.location
        CFAttributedStringSetAttribute(attrString, lastLineRange, kCTParagraphStyleAttributeName, style)
        
        label.attributedString = attrString

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

