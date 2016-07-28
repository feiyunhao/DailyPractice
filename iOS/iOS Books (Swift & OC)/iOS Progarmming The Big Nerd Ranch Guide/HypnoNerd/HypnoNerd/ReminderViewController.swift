//
//  ReminderViewController.swift
//  HypnoNerd
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func addReminder(sender: AnyObject) {
        let data = self.datePicker.date
        print("Setting a reminder for",data)
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = data
        UIApplication.sharedApplication().scheduleLocalNotification(note)

        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "gege"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
