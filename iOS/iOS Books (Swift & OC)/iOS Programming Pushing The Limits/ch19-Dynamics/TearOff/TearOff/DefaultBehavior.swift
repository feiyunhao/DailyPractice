//
//  DefaultBehavior.swift
//  TearOff
//
//  Created by feiyun on 16/7/9.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class DefaultBehavior: UIDynamicBehavior {
    
    let collisionBehavior = UICollisionBehavior()
    let gravityBehavior = UIGravityBehavior()
    
    override init () {
        super.init()
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        self.addChildBehavior(collisionBehavior)
        self.addChildBehavior(gravityBehavior)
    }
    
    func addItem(item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        gravityBehavior.addItem(item)
    }
}
