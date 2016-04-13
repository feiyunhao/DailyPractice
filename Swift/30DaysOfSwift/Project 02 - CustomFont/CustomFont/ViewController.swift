//
//  ViewController.swift
//  CustomFont
//
//  Created by feiyun on 16/4/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var data = ["30 Days Swift", "为什么", "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，再见🤗 See you next Project", "微博 "]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular"]
    
    var fontRowIndex = 0

    @IBOutlet weak var fontTableView: UITableView!
    
    @IBAction func changeFotBtnDidTouch(sender: AnyObject) {
        fontRowIndex = (fontRowIndex + 1) % 3
        fontTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontTableView.delegate = self
        fontTableView.dataSource = self
        
        for family in UIFont.familyNames() {
            for font in UIFont.fontNamesForFamilyName(family){
                print(font)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = fontTableView.dequeueReusableCellWithIdentifier("FontCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        cell.textLabel?.font = UIFont(name:self.fontNames[fontRowIndex], size:16)
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

