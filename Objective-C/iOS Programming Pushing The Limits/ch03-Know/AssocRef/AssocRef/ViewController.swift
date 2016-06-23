//
//  ViewController.swift
//  AssocRef
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

private var key: Void?

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBAction func buttonAction(sender: AnyObject) {
        
        let alertAction = UIAlertAction(title: "OK", style: .Default){
            [unowned self] in
            let button = objc_getAssociatedObject($0, &key) as? UIButton
            self.buttonLabel.text = button?.titleLabel?.text
        }
        
        objc_setAssociatedObject(alertAction, &key, sender, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let alertController = UIAlertController()
        alertController.addAction(alertAction)
        self.showViewController(alertController, sender: nil)
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

