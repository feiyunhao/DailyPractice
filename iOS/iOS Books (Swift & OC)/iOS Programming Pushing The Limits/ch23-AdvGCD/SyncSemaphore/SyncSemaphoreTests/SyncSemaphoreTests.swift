//
//  SyncSemaphoreTests.swift
//  SyncSemaphoreTests
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import XCTest
@testable import SyncSemaphore

class SyncSemaphoreTests: XCTestCase {
    
    
    func testDownload()  {
        
        let URL = NSURL.init(string: "https://modao.cc/app/UdRkRDdWUttAOZmE5jqhmLYwAV2W50F")!
        var location:NSURL?
        var error: NSError?

        let semaphore = dispatch_semaphore_create(0)
        NSURLSession.sharedSession().downloadTaskWithURL(URL) { (url, response, e) in
            
            location = url
            error = e
            dispatch_semaphore_signal(semaphore)
        }.resume()
        
        let timeoutInSeconds:Int64 = 2
        let timeOut = dispatch_time(DISPATCH_TIME_NOW, timeoutInSeconds*Int64(NSEC_PER_SEC))
        let timeoutResult = dispatch_semaphore_wait(semaphore, timeOut)
        
        XCTAssertEqual(timeoutResult, 0, "Time Out")
        XCTAssertNil(error, String(format:"Received an error:%@", error!))
        XCTAssertNotNil(location,"Did not get a location")

    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
