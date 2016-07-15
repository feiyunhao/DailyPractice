//
//  BasicTableViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa

class BasicTableViewController: UITableViewController {

    let dateSource = Variable([BasicModel]())
    
    let dispaseBag = DisposeBag()
    
    static let initialValue = [
        BasicModel(name: "Jack", age: 18),
        BasicModel(name: "Tim", age: 20),
        BasicModel(name: "Andy", age: 24)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = nil
        tableView.delegate = nil
        
        dateSource.asObservable()
        
    }

   
}
