//
//  ViewController.swift
//  Nerdfeed
//
//  Created by feiyun on 16/8/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController,UISplitViewControllerDelegate {

    var url:NSURL? {
        didSet {
            (self.view as! WKWebView).loadRequest(NSURLRequest(URL: url!))
        }
    }
    
    func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        barButtonItem.title = "Courses";
        
        // Take this bar button item and put it on the left side of the nav item
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    
    func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        if (barButtonItem == self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
    
    
    override func loadView() {
        let webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

