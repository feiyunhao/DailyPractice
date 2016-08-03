//
//  CoursesViewController.swift
//  Nerdfeed
//
//  Created by feiyun on 16/8/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController, NSURLSessionDelegate {
    
    var session: NSURLSession?
    var courses: NSArray = NSArray()
    var webVC: WebViewController?
    
    override init(style: UITableViewStyle) {
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        super.init(style: style)
        self.session = NSURLSession.init(configuration: config, delegate: self, delegateQueue: nil)
        self.fetchFeed()
    }
    
    required init?(coder aDecoder: NSCoder) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        super.init(coder: aDecoder)
        self.session = NSURLSession.init(configuration: config, delegate: self, delegateQueue: nil)
        self.fetchFeed()
    }
    
    func fetchFeed() {
        let requestString = "https://bookapi.bignerdranch.com/private/courses.json"
        let URL = NSURL(string: requestString);
        let req = NSURLRequest(URL: URL!)
        
        let dataTask = self.session!.dataTaskWithRequest(req) { (data, response, error) in
            
            if let jsonObject = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary {
                    print(jsonObject["courses"])
                self.courses = jsonObject["courses"] as! NSArray
                
                dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
            }
        }
        dataTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let course = self.courses[indexPath.row] as! NSDictionary;
        cell.textLabel!.text = course["title"] as? String;
        return cell
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        let cred = NSURLCredential.init(user: "BigNerdRanch", password: "AchieveNerdvana", persistence: .ForSession)
        completionHandler(.UseCredential,cred)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let course =  self.courses[indexPath.row] as! NSDictionary
        let URL = NSURL(string: course["url"] as! String)
        self.webVC?.url = URL!
        
        if self.splitViewController == nil {
            self.navigationController!.pushViewController(self.webVC!,animated:true)
        }
    }

}
