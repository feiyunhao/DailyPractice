//
//  VideoCutter.swift
//  SpotifyVideoBackground
//
//  Created by feiyun on 16/5/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var convert: NSString { return (self as NSString) }
}


public class VideoCutter: NSObject {

    
    /**
     获取 视频url 的方法 (把资源复制到沙盒，播放沙盒文件，搞毛呢)
     
     - parameter url:        视频通用资源定位符
     - parameter startTime:  视频开始的时间点
     - parameter duration:   总时间，视频长度
     - parameter completion: 结束后回调，参数包括资源路径，错误信息
     */
    public func cropVideoWithUrl(videoUrl url: NSURL, startTime: CGFloat, duration: CGFloat, completion: ((videoPath: NSURL?, error: NSError?) ->Void)?) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) { 
            let asset = AVURLAsset(URL: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            var outputURL = paths.objectAtIndex(0) as! String
            print(outputURL)
            let manager = NSFileManager.defaultManager()
            do {
                try manager.createDirectoryAtPath(outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _{
            }
            
            outputURL = outputURL.convert.stringByAppendingPathComponent("output.mp4")
            do {
                try manager.removeItemAtPath(outputURL)
            }catch _{}
            
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = NSURL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                
                // CMTimeMake(a,b)    a当前第几帧, b每秒钟多少帧.当前播放时间a/b
               // CMTimeMakeWithSeconds(a,b)    a当前时间,b每秒钟多少帧.
                let start = CMTimeMakeWithSeconds(Float64(startTime), 60)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 60)
                let range = CMTimeRangeMake(start, duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronouslyWithCompletionHandler { () -> Void in
                    switch exportSession.status {
                    case AVAssetExportSessionStatus.Completed:
                        completion?(videoPath: exportSession.outputURL, error: nil)
                    case AVAssetExportSessionStatus.Failed:
                        print("Failed: \(exportSession.error)")
                    case AVAssetExportSessionStatus.Cancelled:
                        print("Failed: \(exportSession.error)")
                    default:
                        print("default case")
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue()) {}
        }
        
    }
    
    
}
