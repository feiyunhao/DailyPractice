//
//  SelectTableViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias SelectSectionModel = AnimatableSectionModel<String, SelectModel>

class SelectTableViewController: UITableViewController {

    let disposeBag = DisposeBag()

    let sections = Variable([SelectSectionModel]())
    
    static let initialValue: [SelectModel] = [
        SelectModel(name: "Jack", age: 18),
        SelectModel(name: "Tim", age: 20),
        SelectModel(name: "Andy", age: 24)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        tableView.rx_modelSelected(SelectModel)
        .subscribeNext { (model) in
            Alert.showInfo(model.name, message: "\(model.age)")
        }
        .addDisposableTo(disposeBag)
        
//        tableView.rx_itemSelected
//            .subscribeNext { indexPath in
//                let userInfo = SelectTableViewController.initialValue[indexPath.row]
//                Alert.showInfo(userInfo.name, message: "\(userInfo.age)")
//            }.addDisposableTo(disposeBag)
        
        let tvDataSource = RxTableViewSectionedReloadDataSource<SelectSectionModel>()
        tvDataSource.configureCell = { (_, tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCellWithIdentifier("SelectCell") as! SelectTableViewCell
            cell.nameLabel.text = model.name
            cell.ageLabel.text = String(model.age)
            return cell
        }
        
        sections.asObservable()
        .bindTo(tableView.rx_itemsWithDataSource(tvDataSource))
        .addDisposableTo(disposeBag)
    
        sections.value = [SelectSectionModel(model: "", items: SelectTableViewController.initialValue)]
        
    }

}
