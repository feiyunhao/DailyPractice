//
//  ReminderViewController.swift
//  HypnoNerd
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    
    @IBAction func addReminder(sender: AnyObject) {
        let data = self.datePicker.date
        print("Setting a reminder for",data)
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = data
        UIApplication.sharedApplication().scheduleLocalNotification(note)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "haha"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.datePicker.minimumDate = NSDate.init(timeIntervalSinceNow: 60)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
