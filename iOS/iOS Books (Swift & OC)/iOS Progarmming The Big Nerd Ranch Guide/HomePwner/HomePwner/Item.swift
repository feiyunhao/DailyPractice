//
//  Item.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var itemName: String = "Item"
    var serialNumber: String = ""
    var valueInDollars: Int = 0
    var dateCreated: NSDate = NSDate()
    var itemKey: String? = NSUUID().UUIDString
    var thumbnail: UIImage?
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(itemName, forKey: "itemName")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeInt64(Int64(valueInDollars), forKey: "valueInDollars")
        aCoder.encodeObject(thumbnail, forKey: "thumbnail")
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        itemName = aDecoder.decodeObjectForKey("itemName") as! String
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as? String
        valueInDollars = Int(aDecoder.decodeInt64ForKey("valueInDollars"))
        thumbnail = aDecoder.decodeObjectForKey("thumbnail") as? UIImage
    }
    
    init(itemName name: String, valueInDollars value: Int, serialNumber sNumber: String) {
        self.itemName = name
        self.valueInDollars = value
        self.serialNumber = sNumber
        super.init()
    }
    
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
    
    func itemArchivePath() -> String? {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let  documentDirectory = documentDirectories.first
        return documentDirectory! + "/items.archive"
    }
    
    override var description: String {
        return String(format: "%@ (%@): Worth $%d, recorded on %@",
                      self.itemName,
                      self.serialNumber,
                      self.valueInDollars,
                      self.dateCreated )
    }
    
    deinit {
        print("Destroyed:\(self)")
    }
    
    class func randomItem() -> Item {
        
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        let adjectiveIndex = random() % randomAdjectiveList.count
        let nounIndex = random() % randomNounList.count
        
        let randomName = randomAdjectiveList[adjectiveIndex] + randomNounList[nounIndex]
        
        let randomValue = random() % 100
        
        let a = "0".unicodeScalars.first!.value
        let b = "A".unicodeScalars.first!.value
        
        let str1 = String(UnicodeScalar(a + UInt32(rand() % 10)))
        let str2 = String(UnicodeScalar(b + UInt32(rand() % 26)))
        let str3 = String(UnicodeScalar(a + UInt32(rand() % 10)))
        let str4 = String(UnicodeScalar(b + UInt32(rand() % 26)))
        let str5 = String(UnicodeScalar(a + UInt32(rand() % 10)))
        let randomSerialNumber = str1 + str2 + str3 + str4 + str5
        
        let newItem = Item(itemName:randomName,valueInDollars:randomValue,serialNumber: randomSerialNumber)
        return newItem
    }
}
