//
//  RxDelegateViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 21/7/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class RxDelegateViewController: UIViewController {

    @IBOutlet weak var delegateButton: RxDelegateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateButton.delegagte = self
        
        delegateButton.rx_trigger
            .subscribeNext {
                print("rx_trigger")
            }
            .addDisposableTo(rx_disposeBag)
        
        delegateButton.rx_trigger
            .subscribeNext {
                print("rx_trigger2")
            }
            .addDisposableTo(rx_disposeBag)
        
//        delegateButton.delegagte = self
    }

}

extension RxDelegateViewController: RxDelegateButtonDelegate {
    
    func trigger() {
        print("trigger")
    }
    
}
