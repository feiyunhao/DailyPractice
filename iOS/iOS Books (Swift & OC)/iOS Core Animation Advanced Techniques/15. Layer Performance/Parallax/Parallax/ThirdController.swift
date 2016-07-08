//
//  SecondController.swift
//  Parallax
//
//  Created by feiyun on 16/7/8.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit



class ThirdController: UIViewController,UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    var recyclePool = NSMutableSet()
    
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
    
    }
    
    var  finished = true
    
    func updateLayers() {
        
        print(#function)
   
        
        var bounds = self.scrollView.bounds
        bounds.origin = self.scrollView.contentOffset
        bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2)
        
        
        self.recyclePool.addObjectsFromArray(self.scrollView.layer.sublayers ?? [])
        
        var visibleLayers:[CALayer] = Array()
        
        
        func perspective(z: CGFloat) -> CGFloat {
            return CGFloat(CAMERA_DISTANCE/(z + CAMERA_DISTANCE))
        }
        
        
        var recycled = 0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for z in (0..<Int(DEPTH)).reverse()
        {
            var adjusted = bounds
            adjusted.size.width /= perspective(CGFloat(z)*SPACING)
            adjusted.size.height /= perspective(CGFloat(z)*SPACING)
            adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2
            adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2
            
            
            yloop: for y in 0..<Int(HEIGHT)
            {
                if (CGFloat(y)*SPACING < adjusted.origin.y ||
                    CGFloat(y)*SPACING >= adjusted.origin.y + adjusted.size.height)
                {
                    continue
                }
                
                xloop: for x in 0..<Int(WIDTH)
                {
                    if (CGFloat(x)*SPACING < adjusted.origin.x ||
                        CGFloat(x)*SPACING >= adjusted.origin.x + adjusted.size.width)
                    {
                        continue
                    }
                    
                    
                    var layer = self.recyclePool.anyObject() as? CALayer
                    if layer != nil {
                        recycled =  recycled + 1
                        self.recyclePool.removeObject(layer!)
                    }
                    else {
                        layer = CALayer()
                        layer!.frame = CGRectMake(0, 0, SIZE, SIZE)
                    }
                    
                    
                    layer!.position = CGPointMake(CGFloat(x)*SPACING, CGFloat(y)*SPACING);
                    layer!.zPosition = -CGFloat(z)*SPACING;
                    
                    //set background color
                    layer!.backgroundColor = UIColor(white: 1 - CGFloat(z)*(1.0/DEPTH), alpha:1).CGColor
                    
                    //attach to scroll view
                    visibleLayers.append(layer!)
                    
                    //                    print(x,y,z)
                    
                }
            }
        }
        CATransaction.commit()
        self.scrollView.layer.sublayers = visibleLayers
        print("%%%%%%%%%")
        print(visibleLayers.count,"---",WIDTH*HEIGHT*DEPTH,"----", recycled)
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
