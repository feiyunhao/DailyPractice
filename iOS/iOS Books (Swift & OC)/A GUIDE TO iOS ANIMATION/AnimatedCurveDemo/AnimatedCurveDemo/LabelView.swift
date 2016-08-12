//
//  LabelView.swift
//  AnimatedCurveDemo
//
//  Created by feiyun on 16/8/12.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

enum PullState {
    case Up
    case Down
}

let LabelHeight: CGFloat = 50.0

class LabelView: UIView {
    
    let kPullingDownString = "下拉即可刷新..."
    let kPullingUpString   = "上拉即可刷新"
    let kReleaseString     = "松开即可刷新..."
    
    private var kPullingString = ""
    private var titleLabel: UILabel!
    
    var loading: Bool = false
    var progress: CGFloat = 0.0 {
        didSet{
            titleLabel.alpha = progress;
            if !loading {
                if progress >= 1.0 {
                    titleLabel.text = kReleaseString;
                }else{
                    titleLabel.text = kPullingString;
                }
            }else{
                if progress >= 0.91 {
                    titleLabel.text = kReleaseString;
                }else{
                    titleLabel.text = kPullingString;
                }
            }
        }
    }
    
    var state: PullState = .Down {
        didSet{
            kPullingString = (state == .Up ? kPullingUpString : kPullingDownString)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        state = .Down
        titleLabel = UILabel(frame: CGRectMake(0, frame.size.height/2-LabelHeight/2, frame.size.width, LabelHeight))
        titleLabel.text = kPullingString
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
    }


    
}
