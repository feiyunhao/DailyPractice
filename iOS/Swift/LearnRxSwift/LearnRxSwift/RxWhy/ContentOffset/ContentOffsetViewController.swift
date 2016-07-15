//
//  ContentOffsetViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa

class ContentOffsetViewController: UITableViewController {

    let diposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        tableView
        .rx_contentOffset
        .map { $0.y}
        .subscribeNext { [unowned self] in
            self.title = "contentOffset.x = \($0)"
        }.addDisposableTo(diposeBag)
        
        Observable.just([1,2,3,4,5,6,7])
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) {(_, element, cell) in
                cell.textLabel?.text = "\(element)"
        }.addDisposableTo(diposeBag)
        
      
    }

   
}
