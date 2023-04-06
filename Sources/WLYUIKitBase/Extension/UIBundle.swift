//
//  UIBundle.swift
//  Alamofire
//
//  Created by wangxiangbo on 2020/3/30.
//

import Foundation
extension Bundle {

    static public func subBundle(bundleName:String,targetClass: AnyClass) -> Bundle {
        let bundle = Bundle(for: targetClass)

        if let path = bundle.path(forResource: bundleName, ofType: "bundle"),
            let bb = Bundle(path: path) {
            return bb
        }
        return Bundle.main
    }
}
