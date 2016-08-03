//
//  ImageTransformer.swift
//  HomePwner
//
//  Created by feiyun on 16/8/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ImageTransformer: NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSDate.self
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        if value is NSData {
            return value
        }
        if value is UIImage {
            return UIImagePNGRepresentation(value as! UIImage)
        }
        return nil
    }
    
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        return UIImage.init(data: value as! NSData)
    }

}
