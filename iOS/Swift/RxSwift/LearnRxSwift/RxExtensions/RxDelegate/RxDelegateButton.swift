//
//  RxDelegateButton.swift
//  LearnRxSwift
//
//  Created by feiyun on 21/7/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

@objc protocol RxDelegateButtonDelegate: NSObjectProtocol {
    @objc optional func trigger()
}

class RxDelegateButton: UIButton {
    
    weak var delegagte: RxDelegateButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(RxDelegateButton.buttonTap), forControlEvents: .TouchUpInside)
    }
    
    
    @objc private func buttonTap() {
        delegagte?.trigger?()
    }

}
