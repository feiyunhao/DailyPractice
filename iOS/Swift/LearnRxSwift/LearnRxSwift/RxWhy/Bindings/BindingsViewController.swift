//
//  BindingsViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

//import UIKit

import RxSwift
import RxCocoa

class BindingsViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var greetingLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(firstName.rx_text, lastName.rx_text) { $0 + " " + $1 }
            .map{ "Greating \($0)" }
            .bindTo(greetingLabel.rx_text)
            .addDisposableTo(disposeBag)
        
    }

  
}
