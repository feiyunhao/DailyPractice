//
//  MYView.swift
//  Drawing
//
//  Created by feiyun on 16/6/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class MYView: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor(red: 0, green: 0, blue: 1, alpha: 0.1).set()
        self.reverseImageForText("Hello World").drawAtPoint(CGPointMake(0, 50))
        UIRectFillUsingBlendMode(self.bounds, .Normal)
    }
    
    func reverseImageForText(text:String) -> UIImage {
        let kImageHeight:CGFloat = 200
        let kImageWidth:CGFloat = 200
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        let color = UIColor.redColor()
        
        UIGraphicsBeginImageContext(CGSizeMake(kImageWidth, kImageHeight))
        (text as NSString).drawInRect(CGRectMake(0, 0, kImageWidth, kImageHeight), withAttributes: [NSFontAttributeName : font,NSForegroundColorAttributeName : color])
        let textimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIImage(CGImage: textimage.CGImage!, scale: 1.0, orientation: .UpMirrored)
        
    }
}
