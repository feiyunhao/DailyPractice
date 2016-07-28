//
//  DrawView.swift
//  TouchTracker
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var finishedLines:[Line] = []
    var linesInProgress: [NSValue : Line] = [:]
    
    override func awakeFromNib() {
        self.multipleTouchEnabled = true
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = .Round
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
        
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().set()
        for line in finishedLines {
            self.strokeLine(line)
        }
        UIColor.redColor().set()
        for (_ , line) in linesInProgress {
            self.strokeLine(line)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(#function)
        
        for t in touches {
            let location = t.locationInView(self)
            let line = Line()
            line.begin = location
            line.end = location
            let key = NSValue(nonretainedObject: t)
            linesInProgress[key] = line
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(#function)
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            let line = linesInProgress[key]!
            line.end = t.locationInView(self)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(#function)
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            let line = linesInProgress[key]!
            
            finishedLines.append(line)
            linesInProgress[key] = nil
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print(#function)
        for t in touches! {
            let key = NSValue(nonretainedObject: t)
            linesInProgress[key] = nil
        }
        self.setNeedsDisplay()
        
    }

}
