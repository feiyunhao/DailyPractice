//
//  CircleTextContainer.swift
//  CircleLayout
//
//  Created by feiyun on 16/7/13.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CircleTextContainer: NSTextContainer {

    override func lineFragmentRectForProposedRect(proposedRect: CGRect, atIndex characterIndex: Int, writingDirection baseWritingDirection: NSWritingDirection, remainingRect: UnsafeMutablePointer<CGRect>) -> CGRect {
        
        let rect =  super.lineFragmentRectForProposedRect(proposedRect, atIndex: characterIndex, writingDirection: baseWritingDirection, remainingRect: remainingRect)
        
        let size = self.size
        let radius = fmin(size.width, size.height) / 2.0
        let ypos = fabs((proposedRect.origin.y + proposedRect.size.height / 2.0) - radius)
        let width = (ypos < radius) ? 2.0 * sqrt(radius * radius
            - ypos * ypos) : 0.0;
        let circleRect = CGRectMake(radius - width / 2.0,
                                       proposedRect.origin.y,
                                       width,
                                       proposedRect.size.height);
//        print(rect,circleRect,separator: "----")
        print(CGRectGetWidth(CGRectIntersection(rect, circleRect)))
        return CGRectIntersection(rect, circleRect);
    }
}
