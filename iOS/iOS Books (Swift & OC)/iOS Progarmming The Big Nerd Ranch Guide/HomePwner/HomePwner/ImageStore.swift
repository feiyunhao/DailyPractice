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
    
    override init() {
        super.init()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector:#selector(self.clearCache(_:)), name:UIApplicationDidReceiveMemoryWarningNotification  ,object:nil)
        
    }
    
    func clearCache(note: NSNotification) {
        self.dictionary.removeAll()
    }
    
    func setImage(image: UIImage?, forKey key: String) {
        self.dictionary[key] = image
        let imagePath = self.imagePathForKey(key)
        let data = UIImageJPEGRepresentation(image!, 0.5)!
        data.writeToFile(imagePath, atomically: true)
        
    }
    
    func imageForKey(key: String) -> UIImage? {
        var result = self.dictionary[key]
        if result == nil {
            let imagePath = self.imagePathForKey(key)
            result = UIImage(contentsOfFile:imagePath)
            if result != nil {
                self.dictionary[key] = result
            }
        }
        return result
    }
    
    func deleteImageForkey(key: String) {
        self.dictionary.removeValueForKey(key)
        try? NSFileManager.defaultManager().removeItemAtPath(key)
    }
    
    func imagePathForKey(key: String) -> String {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)
        let documentDirectory = documentDirectories.first
        return documentDirectory! + key
    }
}
