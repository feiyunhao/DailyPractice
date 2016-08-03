//
//  Item+CoreDataProperties.swift
//  HomePwner
//
//  Created by feiyun on 16/8/3.
//  Copyright © 2016年 feiyun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import UIKit
import CoreData

extension Item {

    @NSManaged var itemName: String?
    @NSManaged var serialNumber: String?
    @NSManaged var valueInDollars: Int
    @NSManaged var dateCreated: NSDate?
    @NSManaged var itemKey: String?
    @NSManaged var thumbnail: UIImage?
    @NSManaged var orderingValue: Double
    @NSManaged var assetType: NSManagedObject?

}
