//
//  ScrollView.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ScrollView: UIView {
    
    override class func layerClass() -> AnyClass {
        return CAScrollLayer.self
    }
    
    func setUp() -> () {
        self.layer.masksToBounds = true
        let recognizer = UIPanGestureRecognizer.init(target: self, action: #selector(pan(_:)))
        self.addGestureRecognizer(recognizer)
    }
    
    func pan(recognizer: UIPanGestureRecognizer) -> () {
        var offSet = self.bounds.origin
        offSet.x -= recognizer.translationInView(self).x
        offSet.y -= recognizer.translationInView(self).y
        (self.layer as! CAScrollLayer).scrollToPoint(offSet)
        recognizer.setTranslation(CGPointZero, inView: self)
    }
    
    override func awakeFromNib() {
        self.setUp()
    }
}