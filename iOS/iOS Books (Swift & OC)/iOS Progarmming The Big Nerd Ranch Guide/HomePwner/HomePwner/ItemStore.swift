//
//  ItemStore.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import CoreData

class ItemStore: NSObject {
    
    var allItmes: [Item]? {
        return  self.privateItems
    }
    
    var privateItems: [Item]? 
        //= (NSKeyedUnarchiver.unarchiveObjectWithFile(ItemStore.itemArchivePath()) as? [Item]) ?? []
    
    
    var context: NSManagedObjectContext?
    
    var  model: NSManagedObjectModel?
    
    override init() {
        super.init()
        model = NSManagedObjectModel.mergedModelFromBundles(nil)
        let psc = NSPersistentStoreCoordinator.init(managedObjectModel: model!)
        let path = ItemStore.itemArchivePath()
        let URL = NSURL.fileURLWithPath(path)
        print(path)
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: URL, options: nil)
        } catch{
            return
        }
        
        context = NSManagedObjectContext()
        context?.persistentStoreCoordinator = psc
        self.loadAllItems()
    }
    
    static let sharedStore: ItemStore = ItemStore()
    
    func loadAllItems() {
        if self.privateItems == nil {
            let request = NSFetchRequest()
            let e = NSEntityDescription.entityForName("Item", inManagedObjectContext: context!)
            request.entity = e
            let sd = NSSortDescriptor.init(key: "orderingValue", ascending: true)
            request.sortDescriptors = [sd];
           
            guard let result = try? context?.executeFetchRequest(request) else { return }
            privateItems = (result as! Array)
            
            
        }
    }
    
    func creatItem() -> Item {
//        let item = Item()
//        self.privateItems!.append(item)
//        return item
        var order:Double = 0
        
        if self.allItmes?.count == 0 {
            order = 1.0
        } else {
            order = (self.privateItems?.last?.orderingValue)! + 1.0
        }
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context!) as! Item
        item.orderingValue = order
        self.privateItems?.append(item)
        return item
    }
    
    static func itemArchivePath() -> String {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let  documentDirectory = documentDirectories.first
//        return documentDirectory! + "/items.archive"
        return documentDirectory! + "/store.data"
    }
    
    func saveChanges() -> Bool {
        
//        let path = ItemStore.itemArchivePath()
//        return NSKeyedArchiver.archiveRootObject(self.privateItems, toFile: path)
        
        do {
           try context?.save()
        } catch {
            print(error)
            return false
        }
        
        return true
        
    }
    
    
    func removeItem(item: Item) {
//        if let index = self.privateItems!.indexOf(item) {
//            self.privateItems!.removeAtIndex(index)
//            ImageStore.sharedStore.deleteImageForkey(item.itemKey!)
//        }
        
        let key = item.itemKey
        ImageStore.sharedStore.deleteImageForkey(key!)
        self.context?.delete(item)
        self.privateItems?.removeAtIndex((self.privateItems?.indexOf(item))!)
        
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else {
            return
        }
        let item = self.privateItems![fromIndex]
        self.privateItems!.removeAtIndex(fromIndex)
        self.privateItems!.insert(item, atIndex: toIndex)
        
        var lowerBound: Double = 0
        if toIndex > 0 {
            lowerBound = (self.privateItems?[toIndex - 1].orderingValue)!
        } else {
            lowerBound = (self.privateItems?[1].orderingValue)! - 2
        }
        
         var upperBound: Double = 0
        
        if toIndex < (self.privateItems?.count)! - 1 {
            
            upperBound = (self.privateItems?[toIndex + 1].orderingValue)!;
            
        } else {
                
            upperBound = (self.privateItems?[toIndex - 1].orderingValue)! + 2.0;
        }
        
        let newOrderValue = (lowerBound + upperBound) / 2.0;
        
        item.orderingValue = newOrderValue;
    }
    
    func allAssetTypes() -> [NSManagedObject] {
        return []
    }
    
}
