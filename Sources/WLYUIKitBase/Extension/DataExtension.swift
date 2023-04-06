//
//  DataExtension.swift
//  Pods-WLYUIKitBase_Example
//
//  Created by wangxiangbo on 2020/5/11.
//

import Foundation

extension Data {
    
    public static func dataWith(str: String)-> Data {
        
        if let d = NSData(base64Encoded: str, options: .ignoreUnknownCharacters) as? Data {
            return d
        }
        return Data()
    }
}
