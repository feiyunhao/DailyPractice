//
//  ImageStore.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    
    static let sharedStore: ImageStore = ImageStore()
    
    var dictionary: [String:UIImage] = [:]
    
    func setImage(image: UIImage?, forKey key: String) {
        self.dictionary[key] = image
    }
    
    func imageForKey(key: String) -> UIImage? {
        return self.dictionary[key]
    }
    
    func deleteImageForkey(key: String) {
        self.dictionary.removeValueForKey(key)
    }
}
