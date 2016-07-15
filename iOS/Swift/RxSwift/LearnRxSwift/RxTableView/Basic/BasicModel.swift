//
//  BasicModel.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation

struct BasicModel {
    let name: String
    let age: Int
}

extension BasicModel: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

func ==(lhs: BasicModel, rhs: BasicModel) -> Bool {
    return lhs.name == rhs.name
}

extension BasicModel: Comparable { }

func >(lhs: BasicModel, rhs: BasicModel) -> Bool {
    return lhs.age > rhs.age
}

func >=(lhs: BasicModel, rhs: BasicModel) -> Bool {
    return lhs.age >= rhs.age
}

func <(lhs: BasicModel, rhs: BasicModel) -> Bool {
    return lhs.age < rhs.age
}

func <=(lhs: BasicModel, rhs: BasicModel) -> Bool {
    return lhs.age <= rhs.age
}

extension BasicModel: CustomStringConvertible {
    var description: String {
        return "\(name)'s age is \(age)"
    }
}
