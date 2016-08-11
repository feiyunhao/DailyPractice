//
//  DownloadButton.swift
//  DownloadButtonDemo
//
//  Created by feiyun on 16/8/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

let kRadiusShrinkAnim = "cornerRadiusShrinkAnim"
let kRadiusExpandAnim = "radiusExpandAnimation"
let kProgressBarAnimation = "progressBarAnimation"
let kCheckAnimation = "checkAnimation"


class DownloadButton: UIView {

    var progressBarHeight: CGFloat = 0.0
    var progressBarWidth: CGFloat = 0.0
    private var originframe: CGRect = CGRectZero
    private var animating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
        
    }
    
    private func setUpViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleButtonDidTapped(_:)))
        addGestureRecognizer(tap)
        
    }
    
    func handleButtonDidTapped(gesture: UITapGestureRecognizer) {
        if animating {
            return
        }
        animating = true
        originframe = frame
        if let sublayers = layer.sublayers {
            for subLayer in sublayers {
                subLayer.removeFromSuperlayer()
            }
        }
        backgroundColor = UIColor(red: 0.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        layer.cornerRadius = progressBarHeight / 2
        let radiusShrinkAnimation = CABasicAnimation(keyPath: "cornerRadius")
        radiusShrinkAnimation.duration = 0.2
        radiusShrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        radiusShrinkAnimation.fromValue = originframe.height / 2
        radiusShrinkAnimation.delegate = self
        layer.addAnimation(radiusShrinkAnimation, forKey: kRadiusShrinkAnim)
    }
    
    private func progressBarAnimation() {
        let progressLayar = CAShapeLayer()
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(progressBarHeight/2, self.bounds.size.height/2))
        path.addLineToPoint(CGPointMake(self.bounds.size.width - progressBarHeight / 2 , self.bounds.size.height / 2))
        
        progressLayar.path = path.CGPath
        progressLayar.strokeColor = UIColor.whiteColor().CGColor
        progressLayar.lineWidth = progressBarHeight - 6
        progressLayar.lineCap = kCALineCapRound
        
        self.layer.addSublayer(progressLayar)
        
        let pathAnimation = CABasicAnimation(keyPath:"strokeEnd")
        pathAnimation.duration = 2
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.delegate = self
        pathAnimation.setValue(kProgressBarAnimation, forKey: "animationName")
        progressLayar.addAnimation(pathAnimation, forKey: nil)
        
    }
    
    private func checkAnimation() {
        let checkLayer = CAShapeLayer()
        let path = UIBezierPath()
        let rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2)
        path.moveToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/9, y: rectInCircle.origin.y + rectInCircle.size.height*2/3))
        path.addLineToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/3,y: rectInCircle.origin.y + rectInCircle.size.height*9/10))
        path.addLineToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width*8/10, y: rectInCircle.origin.y + rectInCircle.size.height*2/10))
        
        checkLayer.path = path.CGPath
        checkLayer.fillColor = UIColor.clearColor().CGColor
        checkLayer.strokeColor = UIColor.whiteColor().CGColor
        checkLayer.lineWidth = 10.0
        checkLayer.lineCap = kCALineCapRound
        checkLayer.lineJoin = kCALineJoinRound
        self.layer.addSublayer(checkLayer)
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.duration = 0.3;
        checkAnimation.fromValue = 0.0
        checkAnimation.toValue = 1.0
        checkAnimation.delegate = self
        checkAnimation.setValue(kCheckAnimation, forKey:"animationName")
        checkLayer.addAnimation(checkAnimation,forKey:nil)
    }

}

extension DownloadButton {
    
    override func animationDidStart(anim: CAAnimation) {
        if anim.isEqual(self.layer.animationForKey(kRadiusShrinkAnim)) {
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { 
                self.bounds = CGRectMake(0, 0, self.progressBarWidth, self.progressBarHeight)
                }, completion: { (finished) in
                    self.layer.removeAllAnimations()
                    self.progressBarAnimation()
            })
        } else if anim.isEqual(self.layer.animationForKey(kRadiusExpandAnim)) {
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.bounds = CGRect(x: 0, y: 0, width: self.originframe.width, height: self.originframe.height)
                self.backgroundColor = UIColor(red: 0.1803921568627451, green: 0.8, blue: 0.44313725490196076, alpha: 1.0)
                }, completion: { (finished) -> Void in
                    self.layer.removeAllAnimations()
                    self.checkAnimation()
                    self.animating = false
            })
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let animationName = anim.valueForKey("animationName") where animationName.isEqualToString(kProgressBarAnimation) {
            UIView.animateWithDuration(0.3, animations: { 
                if let sublayers = self.layer.sublayers{
                    for subLayer in sublayers {
                        subLayer.opacity = 0.0
                    }
                }
                }, completion: { (finished) in
                    if let sublayers = self.layer.sublayers{
                        for sublayer in sublayers {
                            sublayer.removeFromSuperlayer()
                        }
                    }
                    
                    self.layer.cornerRadius = self.originframe.height / 2
                    let radiusExpandAnimation = CABasicAnimation(keyPath: "cornerRadius")
                    radiusExpandAnimation.duration = 0.2
                    radiusExpandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                    radiusExpandAnimation.fromValue = self.progressBarHeight / 2
                    radiusExpandAnimation.delegate = self
                    self.layer.addAnimation(radiusExpandAnimation, forKey: kRadiusExpandAnim)
            })
            
        }
    }
}