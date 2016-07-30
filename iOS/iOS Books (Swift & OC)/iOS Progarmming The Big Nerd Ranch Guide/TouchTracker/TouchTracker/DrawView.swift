//
//  DrawView.swift
//  TouchTracker
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {

    var finishedLines: [Line] = []
    var linesInProgress: [NSValue : Line] = [:]
    weak var selectedLine: Line?
    var moveRecognizer: UIPanGestureRecognizer!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.set()
    }
    
    func set() {
        self.multipleTouchEnabled = true
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        self.addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        tapRecognizer.delaysTouchesBegan = true
        self.addGestureRecognizer(tapRecognizer)
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        self.addGestureRecognizer(pressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.moveLine(_:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(moveRecognizer)
    }
    
    func doubleTap(tap: UITapGestureRecognizer) {
        self.linesInProgress.removeAll()
        self.finishedLines.removeAll()
        self.setNeedsDisplay()
    }
    
    func tap(tap: UITapGestureRecognizer) {
        let point = tap.locationInView(self)
        selectedLine = self.lineAtPoint(point)
        
        if selectedLine != nil {
            self.becomeFirstResponder()
            let menu = UIMenuController.sharedMenuController()
            let deleteItem = UIMenuItem.init(title: "Delete", action: #selector(deleteLine(_:)))
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        self.setNeedsDisplay()
    }
    
    func longPress(gr: UILongPressGestureRecognizer) {
        if gr.state == .Began {
            let point = gr.locationInView(self)
            selectedLine = self.lineAtPoint(point)
            if selectedLine != nil {
                linesInProgress.removeAll()
            }
            
        } else if gr.state == .Ended {
            self.selectedLine = nil
        }
        self.setNeedsDisplay()
    }
    
    func moveLine(gr: UIPanGestureRecognizer) {
        guard (selectedLine != nil) else { return }
        if gr.state == .Changed {
            let translation = gr.translationInView(self)
            var begin = self.selectedLine!.begin;
            var end = self.selectedLine!.end;
            begin.x += translation.x;
            begin.y += translation.y;
            end.x += translation.x;
            end.y += translation.y;
            self.selectedLine!.begin = begin;
            self.selectedLine!.end = end;
            self.setNeedsDisplay()
            gr.setTranslation(CGPointZero, inView: self)
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    @objc func deleteLine(sender: AnyObject) {
        let index = finishedLines.indexOf { $0 === selectedLine }
        finishedLines.removeAtIndex(index!)
        self.setNeedsDisplay()
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
        UIColor.blueColor().set()
        if let selectedLine = self.selectedLine {
            self.strokeLine(selectedLine)
        }
        UIColor.redColor().set()
        for (_ , line) in linesInProgress {
            self.strokeLine(line)
        }
    }
    
    func lineAtPoint(p: CGPoint) -> Line? {
        for l in self.finishedLines {
            let start = l.begin
            let end = l.end
            
            for i in 0...20 {
                let t = CGFloat(i) / 20.0
                let x = start.x + t * (end.x - start.x);
                let y = start.y + t * (end.y - start.y);
                if (hypot(x - p.x, y - p.y) < 20.0) {
                    return l;
                }
            }
        }
        
         return nil
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == moveRecognizer {
            return true
        }
        return false
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
