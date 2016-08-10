//
//  ViewController.swift
//  GooeySlideMenuDemo
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

let cellIdentifier = "demoCell"

class ViewController: UIViewController {

    var menu: GooeySlideMenu? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuOptions = MenuOptions(
            titles:["首页","消息","发布","发现","个人","设置"],
            buttonHeight: 40.0,
            menuColor: UIColor(red: 0.0, green: 0.722, blue: 1.0, alpha: 1.0),
            blurStyle: .Dark,
            buttonSpace: 30.0,
            menuBlankWidth: 50.0,
            menuClickBlock: { (index,title,titleCounts) in
                print("index:\(index) title:\(title), titleCounts:\(titleCounts)")
        })
        menu = GooeySlideMenu(options: menuOptions)

    }

    @IBAction func didButtonTapped(sender: UIButton) {
        menu!.trigger()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let demoCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        demoCell.textLabel?.text = "NO.\(indexPath.row+1)"
        return demoCell

    }
}
