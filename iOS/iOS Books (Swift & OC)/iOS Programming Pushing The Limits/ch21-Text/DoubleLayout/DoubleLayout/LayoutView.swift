//
//  LayoutView.swift
//  DoubleLayout
//
//  Created by feiyun on 16/7/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class LayoutView: UIView, NSLayoutManagerDelegate {

    @IBOutlet weak var textView: UITextView!
    
    let layoutManager = NSLayoutManager()
    let textContainer1 = NSTextContainer()
    let textContainer2 = NSTextContainer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let size = CGSizeMake(CGRectGetWidth(self.bounds),
                              CGRectGetMidY(self.bounds) * 0.75)
        self.textContainer1.size = size
        self.textContainer2.size = size
        self.layoutManager.delegate = self
        self.layoutManager.addTextContainer(self.textContainer1)
        self.layoutManager.addTextContainer(self.textContainer2)
        
        self.textView.textStorage.addLayoutManager(self.layoutManager)
    }
    
    func layoutManagerDidInvalidateLayout(sender: NSLayoutManager) {
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.drawTextForTextContainer(self.textContainer1, atPoint: CGPointZero)
        let box2Corner = CGPointMake(CGRectGetMinX(self.bounds),
                                         CGRectGetMidY(self.bounds))
        self.drawTextForTextContainer(self.textContainer2, atPoint: box2Corner)
    }
    
    func drawTextForTextContainer(textContainer: NSTextContainer, atPoint point: CGPoint) {
        let box = CGRect.init(origin: point, size: textContainer.size)
        UIRectFrame(box)
        let lm = self.layoutManager
        let range = lm.glyphRangeForTextContainer(textContainer)
        lm.drawBackgroundForGlyphRange(range, atPoint: point)
        lm.drawGlyphsForGlyphRange(range, atPoint: point)
        
        
    }
    

}
