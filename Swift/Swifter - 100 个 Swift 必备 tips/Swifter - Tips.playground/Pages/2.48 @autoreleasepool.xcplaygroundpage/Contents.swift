//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//func loadBigData() {
//    
//    if let path = NSBundle.mainBundle()
//        
//        .pathForResource("big", ofType: "jpg") {
//        
//        for i in 1...10000 {
//            
//            autoreleasepool {
//                
//                生成大量autorelease对象
//                let data = NSData.dataWithContentsOfFile(
//                    
//                    path, options: nil, error: nil)
//                
//                NSThread.sleepForTimeInterval(0.5)
//                
//            }
//            
//        }
//        
//    }
//    
//}



//对于上边的例子，我们并不一定需要加入自动释放
//Swift中更提倡的是使用初始化方法，而不是像上边的那样的类方法来生成对象
//因为加入了可以返回nil的初始化方法，上边的工厂方法已经被删除

//let data = NSData(contentsOfFile: path)
//使用初始化方法的话，我们就不需要面临自动释放的问题了
//每次在超过作用域后，自动内存管理都将为我们处理好内存问题





