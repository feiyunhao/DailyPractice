//
//  AssetTypeViewController.swift
//  HomePwner
//
//  Created by feiyun on 16/8/5.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class AssetTypeViewController: UITableViewController {

    var item: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemStore.sharedStore.allAssetTypes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let allAssetTypes = ItemStore.sharedStore.allAssetTypes
        let assetType = allAssetTypes[indexPath.row]
        let assetLabel = assetType.valueForKey("label") as! String
        cell.textLabel?.text = assetLabel
        if assetType == self.item?.assetType {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
         let allAssetTypes = ItemStore.sharedStore.allAssetTypes
          let assetType = allAssetTypes[indexPath.row]
        self.item?.assetType = assetType
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
