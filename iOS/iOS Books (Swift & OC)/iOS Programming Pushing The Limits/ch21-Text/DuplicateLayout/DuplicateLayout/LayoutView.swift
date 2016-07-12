//
//  LayoutView.swift
//  DuplicateLayout
//
//  Created by feiyun on 16/7/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class LayoutView: UIView, NSLayoutManagerDelegate {
    @IBOutlet weak var textView: UITextView!
    
    let layoutManget = NSLayoutManager()
    let textContraint = NSTextContainer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var size = self.bounds.size
        size.width /= 2
        self.textContraint.size = size
        self.layoutManget.delegate = self
        self.layoutManget.addTextContainer(self.textContraint)
        self.textView.textStorage.addLayoutManager(self.layoutManget)
    }
    
    func layoutManagerDidInvalidateLayout(sender: NSLayoutManager) {
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let lm = self.layoutManget
        let range = lm.glyphRangeForTextContainer(self.textContraint)
        let point = CGPointZero
        lm.drawBackgroundForGlyphRange(range, atPoint: point)
        lm.drawGlyphsForGlyphRange(range, atPoint: point)
    }
    

}
