//
//  NewsTableViewController.swift
//  SliderMenu
//
//  Created by feiyun on 16/5/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController,MenuTransitionManagerDelegate {

    let menuTransitionManager = MenuTransitionManager()
    
    func dismiss()  {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    //    跳转到随意一个页面
//    
//    在有可能进行上级跳转的ViewController文件里加上以下代码，函数名称任起：
//    
//    #pragma mark 定义这个函数，别的ViewController在Exit的时候就能直接跳到这了
//    - (IBAction)goHome:(UIStoryboardSegue *)segue
//    {
//    [[segue sourceViewController] class];
//    }
//    在想要跳转view的Exit上右键，选择这个goHome函数，拉到想要运行的button上，就能够实现跳转了
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! MenuTableViewController
        self.title = sourceController.currentItem
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.destinationViewController as! MenuTableViewController
        menuTableViewController.currentItem = self.title!
        
        menuTableViewController.transitioningDelegate = menuTransitionManager;
        menuTransitionManager.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Everyday Moments"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.backgroundColor = UIColor(red:0.062, green:0.062, blue:0.07, alpha:1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = String(indexPath.section) + "_" + String(indexPath.row)
        
        return cell
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}
