//
//  Array_Extension.swift
//  SwiftDemo
//
//  Created by 中行讯 on 2018/7/24.
//  Copyright © 2018年 Beijing CIC Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Array {

    /// Description: 获取数组的内存地址
    ///
    /// - Parameter array: array description
    /// - Returns: return value description
    public func getBufferaddress<T>(array: [T]) -> String {
        return array.withUnsafeBufferPointer {
            return String(describing: $0)
        }
    }

    /// Description：剔除数组中满足条件的元素（我们只要把调用转发给filter，然后把指定的条件取反就好了）
    ///
    /// - Parameter predicate: predicate description
    /// - Returns: return value description
    public func reject(_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }

    /// 交换两个元素
    public mutating func replaceObject(item: Element, index: NSInteger) {
        self.remove(at: index)
        self.insert(item, at: index)
    }
    /// contains 是 是否有满足条件的
    /// 如果的取反 n没有不满族条件的元素，也就是全部元素都满足了
    func allMatch(_ predicate: (Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}


// 安全获取 集合制定位置的元素
extension Collection {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// SwifterSwift: Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    public func group(by size: Int) -> [[Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }
}
