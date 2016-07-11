//
//  TableViewController.swift
//  InteractiveCustomTransitionsDemo
//
//  Created by feiyun on 16/7/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var objects = Array<NSDate>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject))
        self.navigationItem.rightBarButtonItem = addButton
        
    }

    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1 
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let src = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let dest = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let centerPoint = src?.view.center
        dest?.view.frame = CGRectMake(centerPoint!.x, centerPoint!.y, 10, 10)
        src?.view.superview?.addSubview((dest?.view)!)
        UIView.animateWithDuration(1, animations: { 
            dest!.view.frame = UIScreen.mainScreen().bounds//CGRectMake(10, 10, 300, src!.view.frame.size.height - 20)
            dest!.view.center = centerPoint!

            }) { (Bool) in
                src?.view.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func insertNewObject() {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath.init(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailVC")
        detailVC.transitioningDelegate = self
        self.navigationController?.presentViewController(detailVC, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = objects[indexPath.row].description
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }
    }
    
   

}
