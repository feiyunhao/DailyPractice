//
//  RxOptionalViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 21/7/21.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxOptional
import NSObject_Rx

class RxOptionalViewController: UIViewController {
    
    @IBOutlet weak var withoutRxOptionalTableView: UITableView!
    
    @IBOutlet weak var withRxOptionalTableView: UITableView!
    
//    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable<String?>.of("Swift", nil, "SwiftGG", "T")
        
        items
//            .filter { $0 != nil }
            .reduce([]) { $0 + [$1] }
            .bindTo(withoutRxOptionalTableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element//"\(element)"
            }
//            .addDisposableTo(disposeBag)
            .addDisposableTo(rx_disposeBag)
        
        items
            .filterNil()
            .reduce([]) { $0 + [$1] }
            .bindTo(withRxOptionalTableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element//"\(element)"
            }
//            .addDisposableTo(disposeBag)
            .addDisposableTo(rx_disposeBag)
        
    }

}
