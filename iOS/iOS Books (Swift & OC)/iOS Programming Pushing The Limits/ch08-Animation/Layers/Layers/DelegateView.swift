//
//  DelegateView.swift
//  Layers
//
//  Created by feiyun on 16/6/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import QuartzCore
class DelegateView: UIView {

    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        UIGraphicsPushContext(ctx);
        UIColor.whiteColor().set()
        UIRectFill(layer.bounds)
        
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        let color = UIColor.blackColor()
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        let attribs = [NSFontAttributeName : font,
                       NSForegroundColorAttributeName : color,
                       NSParagraphStyleAttributeName : style]
        let text = NSAttributedString(string: "Pushing The Limits", attributes: attribs)
        text.drawInRect(CGRectInset(layer.bounds, 10, 100))
        UIGraphicsPopContext()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.setNeedsDisplay()
        self.layer.contentsScale = UIScreen.mainScreen().scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
