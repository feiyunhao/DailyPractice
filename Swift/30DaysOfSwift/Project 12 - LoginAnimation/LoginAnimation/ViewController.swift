//
//  ViewController.swift
//  LoginAnimation
//
//  Created by feiyun on 16/5/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func backBtnDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var centerAlentUserName: NSLayoutConstraint!
    
    @IBOutlet weak var centerAlentPassword: NSLayoutConstraint!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlentPassword.constant -= view.bounds.width
        centerAlentUserName.constant -= view.bounds.width
        loginBtn.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
            self.centerAlentUserName.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.10, options: .CurveEaseOut, animations: {
            
            self.centerAlentPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.20, options: .CurveEaseOut, animations: {
            
            self.loginBtn.alpha = 1
            
            }, completion: nil)
    }
    
    
    @IBAction func logInBtnDidTouch(sender: AnyObject) {
        
        let bounds = self.loginBtn.bounds
        
        //Animate
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.loginBtn.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginBtn.enabled = false
            
            }, completion: { finished in UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 10, options: .CurveLinear, animations: {
                self.loginBtn.bounds = bounds
                self.loginBtn.enabled = false
                }, completion: { finished in self.loginBtn.enabled = true }) })
        
        
       
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

