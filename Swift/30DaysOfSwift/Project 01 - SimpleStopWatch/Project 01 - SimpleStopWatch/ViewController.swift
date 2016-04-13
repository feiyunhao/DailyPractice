//
//  ViewController.swift
//  Project 01 - SimpleStopWatch
//
//  Created by feiyun on 16/4/11.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var pauseBtn: UIButton!
    
    
    var Counter = 0.0;
    var Timer = NSTimer()
    var isPlaying = false
    
    
    
    
    
   

    @IBOutlet weak var timeLabel: UILabel!
  
    override func viewDidLoad() {
        timeLabel.text = String(Counter)
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func resetButtonDidTouched(sender: AnyObject) {
        Timer.invalidate()
        isPlaying = false
        Counter = 0.0
        timeLabel.text = String(Counter)
        startBtn.enabled = true
        pauseBtn.enabled = true
        
    }

    @IBAction func startButtonDidTouch(sender: AnyObject) {
        if isPlaying {
            return
        }
        startBtn.enabled = false
        pauseBtn.enabled = true
        Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(sender: AnyObject) {
        startBtn.enabled = true
        pauseBtn.enabled = false
        Timer.invalidate()
        isPlaying = false
        
    }
    func UpdateTimer () {
        Counter = Counter + 0.1
        timeLabel.text = String(format: "%.1f",Counter)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

