//
//  SectionsModel.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionsModel {
    let name: String
    let age: Int
}

extension SectionsModel: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

extension SectionsModel: IdentifiableType {
    var identity: Int {
        return hashValue
    }
}

func ==(lhs: SectionsModel, rhs: SectionsModel) -> Bool {
    return lhs.name == rhs.name
}

extension SectionsModel: CustomStringConvertible {
    var description: String {
        return "\(name)'s age is \(age)"
    }
}