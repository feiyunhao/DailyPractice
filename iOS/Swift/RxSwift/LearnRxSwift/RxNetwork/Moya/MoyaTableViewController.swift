//
//  MoyaTableViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias MoyaSectionModel = AnimatableSectionModel<String,UserModel>

class MoyaTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var sections = Variable([MoyaSectionModel]())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.dataSource = nil
        tableView.delegate = nil
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<MoyaSectionModel>()
        tableViewDataSource.configureCell = { (_, tableView, index, model) in
            let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as! UserTableViewCell
            cell.nameLabel.text = model.name
            cell.ageLabel.text = String(model.age)
            return cell
        }
        
        sections.asObservable()
            .bindTo(tableView.rx_itemsWithDataSource(tableViewDataSource))
            .addDisposableTo(disposeBag)
        
        UserProvider
            .request(.Users)
            .mapObject(UserListModel)
            .subscribeNext { [unowned self] userList in
                self.sections.value.append(MoyaSectionModel(model: "Users", items: userList.users))
        }
        .addDisposableTo(disposeBag)
        
    }
    
    
    
}