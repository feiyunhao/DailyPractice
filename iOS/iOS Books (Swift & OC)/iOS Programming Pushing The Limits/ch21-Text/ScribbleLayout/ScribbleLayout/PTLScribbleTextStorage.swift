//
//  PTLScribbleTextStorage.swift
//  ScribbleLayout
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

let PTLDefaultTokenName = "PTLDefaultTokenName"
let PTLRedactStyleAttributeName = "PTLRedactStyleAttributeName"
let PTLHighlightColorAttributeName = "PTLHighlightColorAttributeName"

var a = 1

class PTLScribbleTextStorage: NSTextStorage {
    
    var dynamicTextNeedsUpdate = false
    var tokens: [String : [String : AnyObject]?] = [:]
    
    // MARK: - NSTextStorage 子类模版
    let backingStore = NSMutableAttributedString()
    
    override var string: String {
        return self.backingStore.string
    }
    
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [String : AnyObject] {
        return self.backingStore.attributesAtIndex(location, effectiveRange: range)
    }

    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        self.beginEditing()
        self.backingStore.replaceCharactersInRange(range, withString: str)
        self.edited([.EditedAttributes, .EditedCharacters], range: range, changeInLength: str.characters.count - range.length)
        self.dynamicTextNeedsUpdate = true
        self.endEditing()
    }
    
    override func setAttributes(attrs: [String : AnyObject]?, range: NSRange) {
        self.beginEditing()
        self.backingStore.setAttributes(attrs, range: range)
        self.edited(.EditedAttributes, range: range, changeInLength: 0)
        self.endEditing()
    }
    // MARK: 
    
    override func processEditing() {
        
        func performReplacementsForCharacterChangeInRange(changedRange: NSRange) {
            let string = self.backingStore.string
            let startLine = NSMakeRange(changedRange.location, 0);
            let endLine = NSMakeRange(NSMaxRange(changedRange), 0);
            var extendedRange = NSUnionRange(changedRange,
                                             (string as NSString).lineRangeForRange(startLine))
            extendedRange = NSUnionRange(extendedRange,
                                         (string as NSString).lineRangeForRange(endLine))
            applyTokenAttributesToRange(extendedRange)
        }
        
        func applyTokenAttributesToRange(searchRange: NSRange) {
            let defaultAttributes = self.tokens[PTLDefaultTokenName]
            (string as NSString).enumerateSubstringsInRange(searchRange, options: .ByWords) { (substring, substringRange, enclosingRange, stop) in
                var attributesForToken = self.tokens[substring!]
                if attributesForToken == nil {
                    attributesForToken = defaultAttributes;
                }
                if attributesForToken != nil {
                    self.setAttributes(attributesForToken!, range: substringRange)
                }
            }
        }

        if self.dynamicTextNeedsUpdate {
            self.dynamicTextNeedsUpdate = false
            performReplacementsForCharacterChangeInRange(self.editedRange)
        }
        super.processEditing()
    }
    
    
}
