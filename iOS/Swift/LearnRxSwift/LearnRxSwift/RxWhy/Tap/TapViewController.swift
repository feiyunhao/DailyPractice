//
//  TapViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa

class TapViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        button.rx_tap
            .subscribeNext {
            print("Tap")
        }.addDisposableTo(disposeBag)
    }

    
}
