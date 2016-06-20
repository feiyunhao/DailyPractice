//: [Previous](@previous)

import Foundation
import UIKit
var str = "Hello, playground"

//: [Next](@next)

do {
    let textLabel = UILabel(frame: CGRectMake(150, 80, 20, 40))
    //...
}

let titleLabel:UILabel = {
    
    let label = UILabel(frame: CGRectMake(150, 30, 20, 40))
    
    label.textColor = UIColor.redColor()
    
    label.text = "Title"
    
    return label
    
}()


//在Objective－C中一个很棒的技巧是使用GNU C的声明扩展在限制局部作用域结束的时候同时进行赋值
/*
self.titleLabel = ({
    
    UILabel *label = [[UILabel alloc]
        
        initWithFrame:CGRectMake(150, 30, 20, 40)];
    
    label.textColor = [UIColor redColor];
    
    label.text = @"Title";
    
    [view addSubview:label];
    
    label;
    
});
 
 */