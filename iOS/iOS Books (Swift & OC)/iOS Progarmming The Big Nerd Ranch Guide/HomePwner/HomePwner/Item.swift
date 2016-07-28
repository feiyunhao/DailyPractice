//
//  Item.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var itemName: String = "Item"
    var serialNumber: String = ""
    var valueInDollars: Int = 0
    let dateCreated: NSDate!
    let itemKey = NSUUID().UUIDString
    
    
    init(itemName name: String, valueInDollars value: Int, serialNumber sNumber: String) {
        self.itemName = name
        self.valueInDollars = value
        self.serialNumber = sNumber
        self.dateCreated = NSDate()
        super.init()
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
