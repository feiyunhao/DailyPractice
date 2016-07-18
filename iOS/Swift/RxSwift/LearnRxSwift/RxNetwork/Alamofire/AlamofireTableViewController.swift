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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewDataSource = RxTableViewSectionedReloadDataSource<AlamofireSectionModel>()
        
        tableViewDataSource.configureCell = { (_, tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCellWithIdentifier("UserCell") as! UserTableViewCell
            cell.nameLabel.text = model.name
            cell.ageLabel.text = String(model.age)
            return cell
        }
        
        sections.asObservable()
        .bindTo(tableView.rx_itemsAnimatedWithDataSource(tableViewDataSource))
        .addDisposableTo(disposeBag)
        
        let manager = Manager.sharedInstance
        manager.rx_responseJSON(.GET, host + "/users")
        .mapObject
        
        

    }
    
    
    
}
