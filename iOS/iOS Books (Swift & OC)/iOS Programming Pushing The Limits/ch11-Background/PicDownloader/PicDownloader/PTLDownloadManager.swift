//
//  PTLDownloadManager.swift
//  PicDownloader
//
//  Created by feiyun on 16/7/7.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation

let PTLDownloadManagerDidDownloadFileNotification = "PTLDownloadManagerDidDownloadFileNotification"
let PTLDownloadManagerSourceURLKey = "PTLDownloadManagerSourceURLKey"
let PTLDownloadManagerDestinationURLKey = "PTLDownloadManagerDestinationURLKey"


protocol PTLDownloadManagerDelegate {
    func downloadManager(manager: PTLDownloadManager, didFinishDownloadFromURL sourceURL: NSURL, toURL destURL: NSURL) -> Void
}

class PTLDownloadManager:NSObject, NSURLSessionTaskDelegate {
    
    var foregroundSession: NSURLSession!
    var backgroundSession: NSURLSession!
    var backgroundSessionCompletionHandler: (() -> Void)?
    
    static var downloadManagers = [String:PTLDownloadManager]()
    
    class func downloadManagerWithIdentifier(identifier: String) -> PTLDownloadManager? {
        var downloadManager: PTLDownloadManager? = downloadManagers[identifier]
        
        if downloadManager == nil {
            downloadManager = PTLDownloadManager(identifier: identifier)
            downloadManagers[identifier] = downloadManager;
        }
        return downloadManager
    }
    
    private init(identifier:String) {
        super.init()
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(identifier)
        backgroundSession = NSURLSession(configuration: configuration,delegate: self,delegateQueue: nil)
        foregroundSession = NSURLSession.sharedSession()
        
    }
    
    func fetchDataAtURL(url: NSURL, completionHandler: (NSData?, NSError?) -> Void) -> Void {
        print(#function,url)
        let tast = self.foregroundSession.dataTaskWithURL(url) { (data, response, error) in
            completionHandler(data,error)
        }
        tast.resume()
        print("exit:",#function)
    }
    
    func downloadURLToDocuments(url: NSURL) -> Void {
        print(#function,url)
        let tast = self.backgroundSession.dataTaskWithURL(url)
        tast.resume()
    }
    
    
    lazy var documentDirectoryURL = NSURL.fileURLWithPath(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!)
    
    func localURLForRemoteURL(remoteURL: NSURL) -> NSURL {
        let fileName = remoteURL.lastPathComponent
        return documentDirectoryURL.URLByAppendingPathComponent(fileName!)
    }
    
    
    func moveFileFromLocation(location: NSURL, forDownloadTask downloadTask: NSURLSessionDownloadTask) -> Void {
        let sourceUrl = downloadTask.originalRequest?.URL
        let destUrl = self.localURLForRemoteURL(location)
        
        let fm = NSFileManager.defaultManager()
        if fm.fileExistsAtPath(destUrl.path!) {
            do {
                try fm.removeItemAtURL(destUrl)
            } catch {}
        }
        
        do {
            try fm.moveItemAtURL(location, toURL: destUrl)
            NSNotificationCenter.defaultCenter().postNotificationName(PTLDownloadManagerDidDownloadFileNotification, object: self, userInfo: [PTLDownloadManagerSourceURLKey: sourceUrl!,
                PTLDownloadManagerDestinationURLKey: destUrl])
        } catch  {
            print("Could not move file:")
        }
    }
    
    @objc func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
       print(#function)
        self.backgroundSession.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            let count = dataTasks.count + uploadTasks.count + dataTasks.count
            if count == 0 {
                if self.backgroundSessionCompletionHandler != nil {
                    let completionHandler = self.backgroundSessionCompletionHandler
                    self.backgroundSessionCompletionHandler = nil
                    completionHandler!()
                }
            }
        }
        
    }
    
    @objc func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
         print(#function,location)
        self.moveFileFromLocation(location, forDownloadTask: downloadTask)
    }
    
    
    
}