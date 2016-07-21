//
//  RxDelegateButton+Rx.swift
//  LearnRxSwift
//
//  Created by feiyun on 21/7/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//


import RxSwift
import RxCocoa

extension RxDelegateButton {
    
    var rx_delegate: DelegateProxy {
        return proxyForObject(RxDelegateButtonDelegateProxy.self, self)
    }
    
    var rx_trigger: ControlEvent<Void> {
        let source = rx_delegate.observe(#selector(RxDelegateButtonDelegate.trigger)).map { _ in }
        return ControlEvent(events: source)
    }
}
