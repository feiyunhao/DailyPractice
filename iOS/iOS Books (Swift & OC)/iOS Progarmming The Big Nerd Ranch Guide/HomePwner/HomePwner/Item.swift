//
//  Item.swift
//  HomePwner
//
//  Created by feiyun on 16/8/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(Item)
class Item: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func setThumbnailFromImage(image: UIImage) {
        
        let origImageSize = image.size
        let newRect = CGRectMake(0, 0, 40, 40)
        let ratio = max(newRect.size.width / origImageSize.width,
                        newRect.size.height / origImageSize.height)
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, 0)
        
        let path = UIBezierPath.init(roundedRect: newRect, cornerRadius: 5)
        path.addClip()
        
        // 让图片在缩略图绘制范围内居中
        var projectRect: CGRect = CGRect()
        projectRect.size.width = ratio * origImageSize.width;
        projectRect.size.height = ratio * origImageSize.height;
        projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
        projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
        
        image.drawInRect(projectRect)
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        self.thumbnail = smallImage
        
        UIGraphicsEndImageContext()
    }


}
