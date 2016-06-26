//
//  main.swift
//  UIApplicationMain
//
//  Created by feiyun on 16/6/18.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MyApplication
// TODO: MyApplication
// FIXME: MyApplication

class MyApplication: UIApplication {
    override func sendEvent(event: UIEvent) {
        super.sendEvent(event)
        print("Event sent: \(event)");
    }
}

UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))