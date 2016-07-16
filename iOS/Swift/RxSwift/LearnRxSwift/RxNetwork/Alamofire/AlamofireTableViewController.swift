//
//  AlamofireTableViewController.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Alamofire
import RxAlamofire

typealias AlamofireSectionModel = AnimatableSectionModel<String,UserModel>

class AlamofireTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    let sections = Variable([AlamofireSectionModel]())
    
    let tableViewDataSource = RxTableViewSectionedReloadDataSource<AlamofireSectionModel>()
    
    tableViewDataSource.configureCell = { (_, tableView, indexPath, model) in
    let cell = tableView.de
    
    
    }
    
    
}
