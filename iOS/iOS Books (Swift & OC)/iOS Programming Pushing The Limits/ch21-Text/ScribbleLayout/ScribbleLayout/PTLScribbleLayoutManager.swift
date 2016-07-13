//
//  PTLScribbleLayoutManager.swift
//  ScribbleLayout
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class PTLScribbleLayoutManager: NSLayoutManager {
    
    
    override func drawGlyphsForGlyphRange(glyphsToShow: NSRange, atPoint origin: CGPoint) {
        
        func redactCharacterRange(characterRange: NSRange, ifTrue value: Bool?, atPoint origin: CGPoint) {

            let glyphRange = self.glyphRangeForCharacterRange(characterRange,
                actualCharacterRange:nil)
        
            if (value != nil) && value! {
            
                func drawRedactionInRect(rect: CGRect) {
                    let path = UIBezierPath(rect:rect)
                    let minX = CGRectGetMinX(rect);
                    let minY = CGRectGetMinY(rect);
                    let maxX = CGRectGetMaxX(rect);
                    let maxY = CGRectGetMaxY(rect);
                    path.moveToPoint(CGPointMake(minX, minY))
                    path.addLineToPoint(CGPointMake(maxX, maxY))
                    path.moveToPoint(CGPointMake(maxX, minY))
                    path.addLineToPoint(CGPointMake(minX, maxY))
                    path.stroke()
                }

                let context = UIGraphicsGetCurrentContext()
                CGContextSaveGState(context)
                CGContextTranslateCTM(context, origin.x, origin.y)
                UIColor.blackColor().setStroke()
                
                let container = self.textContainerForGlyphAtIndex(glyphRange.location, effectiveRange: nil)
                
                self.enumerateEnclosingRectsForGlyphRange(glyphRange, withinSelectedGlyphRange: NSMakeRange(NSNotFound, 0), inTextContainer: container!, usingBlock: { (rect, stop) in
                    drawRedactionInRect(rect)
                })
                
                CGContextRestoreGState(context)
                
            }else {
                super.drawGlyphsForGlyphRange(glyphRange, atPoint: origin)
            }
        }
        
        let characterRange = self.characterRangeForGlyphRange(glyphsToShow, actualGlyphRange: nil)
        self.textStorage?.enumerateAttribute(PTLRedactStyleAttributeName, inRange: characterRange, options: [.Reverse,.LongestEffectiveRangeNotRequired ], usingBlock: { (value, attributeCharacterRange, stop) in
            
            redactCharacterRange(attributeCharacterRange, ifTrue: value as? Bool, atPoint: origin)
        })
    }
    
    
    
    override func drawBackgroundForGlyphRange(glyphsToShow: NSRange, atPoint origin: CGPoint) {
        
        super.drawBackgroundForGlyphRange(glyphsToShow, atPoint: origin)
        func highlightCharacterRange(highlightedCharacterRange: NSRange, color: UIColor?, atPoint origin: CGPoint, inContext context: CGContextRef) {
            
            CGContextSaveGState(context)
            color!.setFill()
            CGContextTranslateCTM(context, origin.x, origin.y)
            let highlightedGlyphRange = self.glyphRangeForCharacterRange(highlightedCharacterRange, actualCharacterRange: nil)
            let container = self.textContainerForGlyphAtIndex(highlightedGlyphRange.location, effectiveRange: nil)
            
            func drawHighlightInRect(rect: CGRect) {
                let highlightRect = CGRectInset(rect, -3, -3)
                UIRectFill(highlightRect)
                UIBezierPath.init(ovalInRect: highlightRect).stroke()
            }
            
            self.enumerateEnclosingRectsForGlyphRange(highlightedGlyphRange, withinSelectedGlyphRange: NSMakeRange(NSNotFound, 0), inTextContainer: container!) { (rect, stop) in
                drawHighlightInRect(rect)
            }
            CGContextRestoreGState(context)
        }
        
        let context = UIGraphicsGetCurrentContext()
        let characterRange = self.characterRangeForGlyphRange(glyphsToShow, actualGlyphRange: nil)
        self.textStorage?.enumerateAttribute(PTLHighlightColorAttributeName, inRange: characterRange, options: [.Reverse,.LongestEffectiveRangeNotRequired ], usingBlock: { (value, highlightedCharacterRange, stop) in
            if value is UIColor {
                 highlightCharacterRange(highlightedCharacterRange, color: (value as? UIColor), atPoint: origin, inContext: context!)
            }
           
        })
    }
    
}
