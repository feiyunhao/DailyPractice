//
//  SectionsTableViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

//TableSectionModel 是每个 Section 对应的 Model
//里面实际上装了一个 SectionCell 的 Model ，同时带着一个数组，里面装了对应 Section 的所有 CellModel 。
typealias TableSectionModel = AnimatableSectionModel<String, SectionsModel>

class SectionsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
//     SectionsModel 是每个 Cell 对应的 Model
    let sections = Variable([TableSectionModel]())
    
    static let initialValue: [SectionsModel] = [
        SectionsModel(name: "Jack", age: 18),
        SectionsModel(name: "Tim", age: 20),
        SectionsModel(name: "Andy", age: 24)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
//        对比： let dateSource = Variable([BasicModel]())
        let tvDataSource = RxTableViewSectionedReloadDataSource<TableSectionModel>()
        tvDataSource.configureCell = { (_, tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell") as! SectionsTableViewCell
            cell.nameLabel.text = model.name
            cell.ageLabel.text = String(model.age)
            return cell
        }
        
        sections.asObservable()
            .bindTo(tableView.rx_itemsWithDataSource(tvDataSource))
            .addDisposableTo(disposeBag)
        
        sections.value = [TableSectionModel(model: "", items: SectionsTableViewController.initialValue)]
        
//        直接拿到了 Cell 对应的 Model
        tableView.rx_modelSelected(SectionsModel)
        .subscribeNext {
            print($0)
        }
        .addDisposableTo(disposeBag)
    }
}
