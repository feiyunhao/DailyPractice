//
//  ViewController.swift
//  HypnoNerd
//
//  Created by feiyun on 16/7/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarItem.title = "hehe"
    }

    override func loadView() {
        let backgroundView = Hypnosister(frame: UIScreen.mainScreen().bounds)
        self.view = backgroundView
        
        
        let textFieldRect = CGRectMake(40, 70, 240, 30);
        let textField = UITextField(frame:textFieldRect);
        
        // Setting the border style on the text field will allow us to see it easier
        textField.borderStyle = .RoundedRect;
        textField.placeholder = "Hypnotize me";
        textField.returnKeyType = .Done;
        backgroundView.addSubview(textField)
        
        textField.delegate = self;
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.drawHypnoticMessage(textField.text)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    func drawHypnoticMessage(message: String?) {
        for _ in 0...20 {
            let messageLabel = UILabel()
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.text = message
            
            //根据需要显示的文字调整UILabel对象的大小
            messageLabel.sizeToFit()
            
            
            let width = self.view.bounds.size.width - messageLabel.bounds.size.width
            let x = CGFloat(arc4random_uniform(UInt32(width)))
            
            let height = self.view.bounds.size.height - messageLabel.bounds.size.height
            let y = CGFloat(arc4random_uniform(UInt32(height)))
            
            var frame = messageLabel.frame;
            frame.origin = CGPointMake(x, y)
            messageLabel.frame = frame
            
            self.view.addSubview(messageLabel)
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

