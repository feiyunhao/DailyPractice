//
//  SecondController.swift
//  Parallax
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit



class SecondController: UIViewController,UIScrollViewDelegate {
    
    let WIDTH:CGFloat   = 100
    let HEIGHT:CGFloat  = 100
    let DEPTH:CGFloat   = 10
    
    let SIZE:CGFloat    = 100
    let SPACING:CGFloat = 50
    
    let CAMERA_DISTANCE:CGFloat = 500
    
    let scrollView = UIScrollView()
    var retainPool = NSMutableSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING + WIDTH*SIZE, (HEIGHT - 1)*SPACING +  WIDTH*SIZE)
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / CAMERA_DISTANCE
        scrollView.layer.sublayerTransform = transform
        
    }
    
    var  finished = true
    
    func updateLayers() {
        
//        print(#function)
        
        
        var bounds = self.scrollView.bounds
        bounds.origin = self.scrollView.contentOffset
        //需要显示的范围，半个也要现实
        bounds = CGRectInset(bounds, -SIZE, -SIZE)
        
        //TODO:::
        // ？？？求指教
        self.retainPool.addObjectsFromArray(self.scrollView.layer.sublayers ?? [])
//        self.retainPool = NSSet.init(array: (self.scrollView.layer.sublayers ?? []))

        var visibleLayers:[CALayer] = Array()
        
        func perspective(z: CGFloat) -> CGFloat {
            return CGFloat(CAMERA_DISTANCE/(z + CAMERA_DISTANCE))
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for z in (0..<Int(DEPTH)).reverse()
        {
            //increase bounds size to compensate for perspective
            var adjusted = bounds
            adjusted.size.width /= perspective(CGFloat(z)*(SPACING+WIDTH))
            adjusted.size.height /= perspective(CGFloat(z)*(SPACING+WIDTH))
            adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2
            adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2
            
            yloop: for y in 0..<Int(HEIGHT)
            {
                if (CGFloat(y)*(SPACING+WIDTH) < adjusted.origin.y ||
                    CGFloat(y)*(SPACING+WIDTH) >= adjusted.origin.y + adjusted.size.height)
                {
                    continue
                }
                
                xloop: for x in 0..<Int(WIDTH)
                {
                    if (CGFloat(x)*(SPACING+WIDTH) < adjusted.origin.x ||
                        CGFloat(x)*(SPACING+WIDTH) >= adjusted.origin.x + adjusted.size.width)
                    {
                        continue
                    }
                    
                    let layer = CALayer()
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE)
                    
                    layer.position = CGPointMake(CGFloat(x)*(SPACING+WIDTH) + SIZE/2, CGFloat(y)*(SPACING+WIDTH) + SIZE/2);
                    layer.zPosition = -CGFloat(z)*(SPACING+WIDTH);
                    
                    //set background color
                    layer.backgroundColor = UIColor(white: 1 - CGFloat(z)*(1.0/DEPTH), alpha:1).CGColor
                    
                    //attach to scroll view
                    visibleLayers.append(layer)
                }
            }
        }
        CATransaction.commit()
        
        self.scrollView.layer.sublayers = visibleLayers
//        self.retainPool.removeAllObjects()
        print(visibleLayers.count, "---", retainPool.count,"---",WIDTH*HEIGHT*DEPTH)
        
    }
    
    override func viewDidLayoutSubviews() {
//        print(#function)
        self.updateLayers()
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(#function)
        self.updateLayers()
    }
    
    override func didReceiveMemoryWarning() {
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
