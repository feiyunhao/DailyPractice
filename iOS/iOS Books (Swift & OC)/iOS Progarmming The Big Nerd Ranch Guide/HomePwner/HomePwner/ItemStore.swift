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
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Homepwner", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("store.data")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    var allItmes: [Item]? {
        return  self.privateItems
    }
    
    var privateItems: [Item]? 

    lazy var allAssetTypes: [NSManagedObject] = {
        let request = NSFetchRequest()
        let e = NSEntityDescription.entityForName("AssetType", inManagedObjectContext: self.managedObjectContext)
        request.entity = e
       var allAssetTypes = (try! self.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject])
        
        if allAssetTypes!.count == 0 {
            var type: NSManagedObject?
            type = NSEntityDescription.insertNewObjectForEntityForName("AssetType", inManagedObjectContext: self.managedObjectContext)
            type?.setValue("Furniture", forKey: "label")
            allAssetTypes?.append(type!)
            
            type = NSEntityDescription.insertNewObjectForEntityForName("AssetType", inManagedObjectContext: self.managedObjectContext)
            type?.setValue("Jewelry", forKey: "label")
            allAssetTypes?.append(type!)
            
            type = NSEntityDescription.insertNewObjectForEntityForName("AssetType", inManagedObjectContext: self.managedObjectContext)
            type?.setValue("Electronics", forKey: "label")
            allAssetTypes?.append(type!)
            
        }
        return allAssetTypes!
    }()
    
    override init() {
        super.init()
        self.loadAllItems()
        
    }
    
    static let sharedStore: ItemStore = ItemStore()
    
    func loadAllItems() {
        if self.privateItems == nil {
            let request = NSFetchRequest()
            let e = NSEntityDescription.entityForName("Item", inManagedObjectContext: self.managedObjectContext)
            request.entity = e
            let sd = NSSortDescriptor.init(key: "orderingValue", ascending: true)
            request.sortDescriptors = [sd];
           
            guard let result = try? self.managedObjectContext.executeFetchRequest(request) else { return }
            privateItems = (result as! Array)
        }
    }
    
    func creatItem() -> Item {
        var order:Double = 0
        if self.allItmes?.count == 0 {
            order = 1.0
        } else {
            order = (self.privateItems?.last?.orderingValue)! + 1.0
        }
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: self.managedObjectContext) as! Item
        item.orderingValue = order
        self.privateItems?.append(item)
        return item
    }
    
    func saveChanges() -> Bool {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
    
    
    func removeItem(item: Item) {
        let key = item.itemKey
        ImageStore.sharedStore.deleteImageForkey(key!)
        self.managedObjectContext.deleteObject(item)
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
    
}
