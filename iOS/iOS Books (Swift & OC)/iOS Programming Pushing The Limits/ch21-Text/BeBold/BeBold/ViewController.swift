//
//  ViewController.swift
//  BeBold
//
//  Created by feiyun on 16/7/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let str = "Be Bold! And a little color wouldn’t hurt either."
        
        let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(36)]
        
        let attributedString = NSMutableAttributedString.init(string: str, attributes: attrs)
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(36), range: (str as NSString).rangeOfString("Bold!"))
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor().CGColor, range: (str as NSString).rangeOfString("little color"))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: (str as NSString).rangeOfString("little"))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Papyrus", size: 36)!, range: (str as NSString).rangeOfString("color"))
        
        label.attributedText = attributedString
        
    }

    @IBAction func toggleItalic(sender: AnyObject) {
        
        let attributedStr: NSMutableAttributedString = (self.label.attributedText?.mutableCopy())! as! NSMutableAttributedString
        
        attributedStr.enumerateAttribute(NSFontAttributeName, inRange: NSMakeRange(0, attributedStr.length), options: .LongestEffectiveRangeNotRequired) { (value, range, stop) in
            
            let font = value as! UIFont
            let descriptor = font.fontDescriptor()
            var traits: UIFontDescriptorSymbolicTraits = descriptor.symbolicTraits
            if traits.contains(.TraitItalic) {
                traits.remove(.TraitItalic)
            } else {
                traits.insert(.TraitItalic)
            }
            let toggledDescriptor = descriptor.fontDescriptorWithSymbolicTraits(traits)
            let italicFont: UIFont? = UIFont.init(descriptor: toggledDescriptor, size: 0)
            
            if italicFont != nil {
                attributedStr.addAttribute(NSFontAttributeName, value: italicFont!, range: range)
            }else {
                
            }
            
            
        }
        self.label.attributedText = attributedStr
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

