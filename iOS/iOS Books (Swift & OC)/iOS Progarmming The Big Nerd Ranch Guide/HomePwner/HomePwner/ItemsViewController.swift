//
//  ItemsViewController.swift
//  HomePwner
//
//  Created by feiyun on 16/7/28.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
//    @IBOutlet var headerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: [:])
//        self.tableView.tableHeaderView = headerView!
        
        let navItem = self.navigationItem
        navItem.title = "Homepwner"
        let bbi = UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: #selector(self.addNewItem(_:)))
        navItem.rightBarButtonItem = bbi
        navItem.leftBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Table

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = DetailViewController.init(newItem: false)
        let item = ItemStore.sharedStore.allItmes[indexPath.row]
        detailViewController.item = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.sharedStore.allItmes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)

        let items = ItemStore.sharedStore.allItmes
        let item = items[indexPath.row]
        cell.textLabel?.text = item.description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = ItemStore.sharedStore.allItmes[indexPath.row]
            ItemStore.sharedStore.removeItem(item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        ItemStore.sharedStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    @IBAction func addNewItem(sender: UIButton) {
        let newItem = ItemStore.sharedStore.creatItem()
        
        let detailViewController = DetailViewController.init(newItem: true)
        detailViewController.item = newItem
        detailViewController.dismissBlock = {
            self.tableView.reloadData()
        }
        
        let nav = UINavigationController.init(rootViewController: detailViewController)
        nav.modalPresentationStyle = .FormSheet
        
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func toggleEditingMode(sender: UIButton) {
        if self.editing {
            sender.setTitle("Edit", forState: .Normal)
            self.setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", forState: .Normal)
            self.setEditing(true, animated: true)
        }
    }
}
