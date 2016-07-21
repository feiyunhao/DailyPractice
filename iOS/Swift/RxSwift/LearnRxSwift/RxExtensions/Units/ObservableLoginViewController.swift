//
//  ObservableLoginViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 21/7/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Alamofire
import RxAlamofire

class ObservableLoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: ObservableLoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

}
