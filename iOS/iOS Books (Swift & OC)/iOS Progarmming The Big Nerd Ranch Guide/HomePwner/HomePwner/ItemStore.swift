//
//  ItemStore.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ItemStore: NSObject {
    
    var allItmes: [Item] {
        return  self.privateItems
    }
    
    var privateItems: [Item] = []
    
    static let sharedStore: ItemStore = ItemStore()
    
    func creatItem() -> Item {
        let item = Item.randomItem()
        self.privateItems.append(item)
        return item
    }
    
    func removeItem(item: Item) {
        if let index = self.privateItems.indexOf(item) {
            self.privateItems.removeAtIndex(index)
            ImageStore.sharedStore.deleteImageForkey(item.itemKey)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        let item = self.privateItems[fromIndex]
        self.privateItems.removeAtIndex(fromIndex)
        self.privateItems.insert(item, atIndex: toIndex)
    }
    
}
