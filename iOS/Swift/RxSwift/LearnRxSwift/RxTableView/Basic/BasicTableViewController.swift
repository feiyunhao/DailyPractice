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

//     Variable 的属性 value 只要有改变，就会发射数据
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
            .map { $0.sort(>) }
//            bindTo 基本是起到一个效果的，都是将数据实时的绑定到 View 上
            .bindTo(tableView.rx_itemsWithCellIdentifier("BasicCell", cellType: BasicTableViewCell.self)) { (_, element, cell) in
                cell.nameLabel.text = element.name
                cell.ageLabel.text = String(element.age)
            }.addDisposableTo(dispaseBag)
        
        dateSource.value.appendContentsOf(BasicTableViewController.initialValue)
        
        tableView.rx_modelSelected(BasicModel)
            .subscribeNext { (model) in
            Alert.showInfo(model.name, message: String(model.age))
        }.addDisposableTo(dispaseBag)
        
    }

   
}
