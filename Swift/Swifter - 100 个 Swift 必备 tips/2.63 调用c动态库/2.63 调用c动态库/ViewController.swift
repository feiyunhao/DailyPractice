//
//  ViewController.swift
//  2.63 调用c动态库
//
//  Created by feiyun on 16/6/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("haha".MD5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// StringMD5.swift

extension String {
    
    var MD5: String {
        
        let cString = self.cStringUsingEncoding(NSUTF8StringEncoding)
        
        let length = CUnsignedInt(
            
            self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            
        )
        
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(
            
            Int(CC_MD5_DIGEST_LENGTH)
            
        )
        
        CC_MD5(cString!, length, result)
        
        return String(format:
            
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      
                      result[0], result[1], result[2], result[3],
                      
                      result[4], result[5], result[6], result[7],
                      
                      result[8], result[9], result[10], result[11],
                      
                      result[12], result[13], result[14], result[15])
        
    }
    
}

// ၦᦷ

