//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//AnyClass

//typealias AnyClass = AnyObject.Type
//AnyObject.Type 元类型
//声明时总是在类型名字后边加上.Tpye
//A.Type A这个类型的类型
//从A获取其类型：.self

class A {
    class func method() {
        print("Hello")
    }
}

let typeA0: AnyClass = A.self
let typeA: A.Type = A.self

typeA.method()
A.method()

let anyClass: AnyClass = A.self
(anyClass as! A.Type).method()

import UIKit
class MusicViewController: UIViewController {
    
}

class AlbumViewController: UIViewController {
    
}

//元类型存入数组并传递给别的方法
let usingVCTypes: [AnyClass] = [MusicViewController.self,
                                AlbumViewController.self]

func setupViewControllers(vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
        
    }
}

setupViewControllers(usingVCTypes)

UITableView().registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")

//.Tpye某个类型的元类型 class ，struct，enum， 
//protocol .Protocol
typealias strType = String
let strMeta = String.self




