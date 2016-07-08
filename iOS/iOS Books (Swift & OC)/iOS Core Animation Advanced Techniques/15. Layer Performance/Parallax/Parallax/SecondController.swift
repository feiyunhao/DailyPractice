//
//  SecondController.swift
//  Parallax
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class SecondController: UIViewController,UIScrollViewDelegate {

    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING)
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / CAMERA_DISTANCE
        scrollView.layer.sublayerTransform = transform
        
//        self.updateLayers()

    }

    var  finished = true
    
    func updateLayers() {
        
        self.scrollView.layer.sublayers = []
        print(#function)
//        if !finished {
//            return
//        } else {
//            finished = false
//        }
        
        
        var bounds = self.scrollView.bounds
        bounds.origin = self.scrollView.contentOffset
        bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2)
        
        var visibleLayers:[CALayer] = Array()
        
        
        func perspective(z: CGFloat) -> CGFloat {
            return CGFloat(CAMERA_DISTANCE/(z + CAMERA_DISTANCE))
        }
        
        for z in (0..<Int(DEPTH)).reverse()
        {
//            var adjusted = bounds
//            adjusted.size.width /= perspective(CGFloat(z)*SPACING)
//            adjusted.size.height /= perspective(CGFloat(z)*SPACING)
//            adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2
//            adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2
            
            
            yloop: for y in 0..<Int(HEIGHT)
            {
//                if (CGFloat(y)*SPACING < adjusted.origin.y ||
//                    CGFloat(y)*SPACING >= adjusted.origin.y + adjusted.size.height)
//                {
//                    continue yloop;
//                }
                
                xloop: for x in 0..<Int(WIDTH)
                {
//                    if (CGFloat(x)*SPACING < adjusted.origin.x ||
//                        CGFloat(x)*SPACING >= adjusted.origin.x + adjusted.size.width)
//                    {
//                        continue xloop;
//                    }
                    
                    let layer = CALayer()
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE)
                    layer.position = CGPointMake(CGFloat(x)*SPACING, CGFloat(y)*SPACING);
                    layer.zPosition = -CGFloat(z)*SPACING;
                    
                    //set background color
                    layer.backgroundColor = UIColor(white: 1 - CGFloat(z)*(1.0/DEPTH), alpha:1).CGColor
                    
                    //attach to scroll view
                    visibleLayers.append(layer)
                    
//                    print(x,y,z)

                }
            }
        }
        
        self.scrollView.layer.sublayers = visibleLayers
        finished = true
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
        self.updateLayers()
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(#function)
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
