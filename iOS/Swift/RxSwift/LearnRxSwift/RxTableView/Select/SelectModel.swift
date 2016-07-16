///
//  SelectModel.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation
import RxDataSources

struct SelectModel {
    let name: String
    let age: Int
}

extension SelectModel: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

extension SelectModel: IdentifiableType {
    var identity: Int {
        return hashValue
    }
}

func ==(lhs: SelectModel, rhs: SelectModel) -> Bool {
    return lhs.name == rhs.name
}

extension SelectModel: CustomStringConvertible {
    var description: String {
        return "\(name)'s age is \(age)"
    }
}
