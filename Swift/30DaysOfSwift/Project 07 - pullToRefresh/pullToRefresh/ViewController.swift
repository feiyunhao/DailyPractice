//
//  ViewController.swift
//  pullToRefresh
//
//  Created by feiyun on 16/4/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    let cellIdentifier = "NewCellIdentifier"
    let favoritEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let  newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸"]
    var emojiData = [String]()
    var tableViewController = UITableViewController(style: .Plain)
    var refreshControl = UIRefreshControl()
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 64))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emojiData = favoritEmoji
        let emojiTableView = tableViewController.tableView
        emojiTableView.backgroundColor = UIColor.lightGrayColor()
        emojiTableView.dataSource = self
        emojiTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "emoji")
        tableViewController.refreshControl = self.refreshControl
        self.refreshControl.backgroundColor = UIColor(red: 0.113, green: 0.113, blue: 0.113, alpha: 1)
        self.refreshControl.addTarget(self, action:"customRefresh", forControlEvents: .ValueChanged)
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updata on \(NSDate())",attributes: attributes)
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.title = "emoji"
        self.navBar.barStyle = UIBarStyle.BlackTranslucent
        emojiTableView.rowHeight = UITableViewAutomaticDimension
        emojiTableView.estimatedRowHeight = 60.0
        emojiTableView.tableFooterView = UIView(frame:CGRectZero)
//        emojiTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 64))
        emojiTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(emojiTableView)
        self.view.addSubview(navBar)
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier ("emoji")! as UITableViewCell
        cell.textLabel?.text = self.emojiData[indexPath.row]
        return cell
    }
    func customRefresh() {
        self.emojiData = newFavoriteEmoji
        self.tableViewController.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

