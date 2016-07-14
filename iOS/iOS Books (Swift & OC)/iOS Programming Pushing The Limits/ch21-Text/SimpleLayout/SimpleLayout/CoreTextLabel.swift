//
//  CoreTextLabel.swift
//  SimpleLayout
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CoreTextLabel: UIView {

    var attributedString: NSAttributedString? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let transform = CGAffineTransformMakeScale(1, -1)
        CGAffineTransformTranslate(transform, 0, -self.bounds.size.height)
        self.transform = transform
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetTextMatrix(context, CGAffineTransformIdentity)
        let path = CGPathCreateWithRect(self.bounds, nil)
        let attrString = self.attributedString
        let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        CTFrameDraw(frame, context!)
    }
    

}
