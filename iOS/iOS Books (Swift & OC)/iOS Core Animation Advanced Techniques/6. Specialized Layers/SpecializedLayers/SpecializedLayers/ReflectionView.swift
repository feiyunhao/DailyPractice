//
//  ReflectionView.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/7/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ReflectionView: UIView {

    override class func layerClass() -> AnyClass {
        return CAReplicatorLayer.self
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setUp()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setUp() -> () {
        let layer: CAReplicatorLayer = (self.layer as! CAReplicatorLayer)
        layer.instanceCount = 2
        
        var transform = CATransform3DIdentity
        let verticalOffset = self.bounds.size.height + 2
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        layer.instanceTransform = transform;
        
        //reduce alpha of reflection layer
        layer.instanceAlphaOffset = -0.6;
        
        
    }
    
    override func awakeFromNib() {
        self.setUp()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
