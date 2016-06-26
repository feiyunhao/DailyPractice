//
//  VoideSplashViewController.swift
//  SpotifyVideoBackground
//
//  Created by feiyun on 16/5/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingModel{
    case Resize
    case ResizeAspect
    case ResizeAspectFill
    
    
}
public class VoideSplashViewController: UIViewController {

    private let moviePlayer = AVPlayerViewController()
    private var moviePlayerSounderLevel: Float = 1.0
    public var contentURL: NSURL = NSURL() {
        didSet {
            setMoviePlayer(contentURL)
        }
        
    }
    
    public var videoFrame: CGRect = CGRect()
    public var startTime: CGFloat = 0.0
    public var duration: CGFloat = 0.0
    public var backgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            view.backgroundColor = backgroundColor
        }
        
    }
    
    public var sound: Bool = true {
        didSet {
            if sound {
                moviePlayerSounderLevel = 1.0
            }else{
                moviePlayerSounderLevel = 0.0
            }
        }
    }
    
    public var alpha: CGFloat = CGFloat() {
        didSet {
            moviePlayer.view.alpha = alpha
        }
    }
    
    public var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NSNotificationCenter.defaultCenter() .addObserver(self, selector: #selector(VoideSplashViewController.playerItemDidReachEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    public var fillMode: ScalingModel = .ResizeAspectFill {
        didSet {
            switch fillMode {
            case .Resize:
                moviePlayer.videoGravity = AVLayerVideoGravityResize
            case .ResizeAspect:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case .ResizeAspectFill:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    override public func viewDidAppear(animated: Bool) {
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func playerItemDidReachEnd() {
        moviePlayer.player?.seekToTime(kCMTimeZero)
        moviePlayer.player?.play()
    }
    private func setMoviePlayer(url: NSURL){
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            if let path = videoPath as NSURL? {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.moviePlayer.player = AVPlayer(URL: path)
                        self.moviePlayer.player?.play()
                        self.moviePlayer.player?.volume = self.moviePlayerSounderLevel
                    }
                }
            }
        }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
