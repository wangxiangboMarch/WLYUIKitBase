//
//  Dictionary.swift
//  DynamicBusClient
//
//  Created by zhonghangxun on 2019/6/24.
//  Copyright © 2019 WLY. All rights reserved.
//

import Foundation

extension Dictionary {
    /*
        由于Dictionary是一个struct，并且merge修改了self，我们必须使用mutating关键字修饰这个方法。而对于sequence参数，我们通过where关键字限定了两个内容
            S必须遵从Sequence protocol，Dictionary是众多遵从了Sequence protocol的collection类型之一，但是，我们没必要一定只能合并Dictionary；
            S的元素类型必须和原Dictionary的Element相同，其中Key和Value是Dictionary声明中的两个反省参数；
     */
    /// 合并key value
    public mutating func merge<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            sequence.forEach { self[$0] = $1 }
    }
}

/*
    用一个tuple数组初始化Dictionary
    理解了merge的实现和用法之后，其实，我们很容易把这个场景进一步扩展下，如果我们可以merge类型兼容的Sequence，那么，用这样的Sequence来初始化一个Dictionary也是可以的，把它看成是和一个空的Dictionary进行合并就好了
 */
extension Dictionary {
    init<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            self = [:]
            self.merge(sequence)
    }
}

/// map返回一个Array<RecordType>，但有时，我们仅仅希望对value做一些变换，而仍旧保持Dictionary的类型。为此，我们可以自定义一个“只map value”的方法

extension Dictionary {
    func mapValue<T>(_ transform: (Value) -> T) -> [Key: T] {
        return Dictionary<Key, T>(map { (k, v) in
            return (k, transform(v))
        })
    }
}

//把Set用作内部支持类型
//很多时候，除了把Set作为一个集合类型返回给用户之外，我们还可以把它作为函数的内部支持类型来使用。例如，借助于Set不能包含重复元素的特性，为任意一个序列类型去重
//我们给Sequence添加下面的扩展
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var result: Set<Iterator.Element> = []
        
        return filter {
            if result.contains($0) {
                return false
            }
            else {
                result.insert($0)
                return true
            }
        }
    }
}
