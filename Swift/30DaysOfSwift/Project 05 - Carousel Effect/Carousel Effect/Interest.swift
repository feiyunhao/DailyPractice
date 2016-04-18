//
//  Interest.swift
//  Carousel Effect
//
//  Created by feiyun on 16/4/18.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class Interest: NSObject {

    var title = ""
    var descriptions = ""
    var numberOfMemorys = 0
    var numberOfPost = 0
    var featuredImage: UIImage!
    
    init(title: String,descriptions: String,featuredImage: UIImage!) {
        self.title = title
        self.descriptions = descriptions
        self.featuredImage = featuredImage
        numberOfMemorys = 1
        numberOfPost = 1
    }
    static func createInterests() ->[Interest]{
        
        return[
            
            Interest.init(title: "Hello there, i miss u.", descriptions: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hello")!),
            Interest(title: "🐳🐳🐳🐳🐳", descriptions: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "dudu")!),
            Interest(title: "Training like this, #bodyline", descriptions: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "bodyline")!),
            Interest(title: "I'm hungry, indeed.", descriptions: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "wave")!),
            Interest(title: "Dark Varder, #emoji", descriptions: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "darkvarder")!),
            Interest(title: "I have no idea, bitch", descriptions: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hhhhh")!),
        
        
        
        ]
        
    }
    
    
    
}
