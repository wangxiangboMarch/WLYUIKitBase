//
//  DecimalNumber.swift
//  WLYUIKitBase
//
//  Created by CictecMacMini on 2020/10/19.
//

/**
    关于浮点数据的精确处理
 */
import Foundation

extension String {
    
    /// 返回精度的 字符串 代表的单位是分
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toPrice(scale:Int16 = 2) -> String {
        
        guard let input = Int(self) else {
            return "-"
        }
        let inputNumber = NSDecimalNumber(string: "\(Double(input)/100.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    /// 返回精度的 字符串 代表的单位是元
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toOldPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    /// 拿到金钱类型的handle
    static func priceHandler(scale:Int16 = 2) -> NSDecimalNumberHandler {
        return NSDecimalNumberHandler(roundingMode: .plain,
                                      scale: scale,
                                      raiseOnExactness: false,
                                      raiseOnOverflow: false,
                                      raiseOnUnderflow: false,
                                      raiseOnDivideByZero: true)
    }
    /// 安全Double
    public func toSafeDouble() -> Double {
        guard let input = Double(self) else {
            return 0
        }
        return input
    }
    
}

extension Double {
    
    /// 返回精度的 字符串 代表的单位是分
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self/100.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    /// 返回精度的 字符串 代表的单位是元
    /// - Parameter scale: 保留的小数位
    /// - Returns: 返回结构化的字符串
    public func toNomalPrice(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(self)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
    
    public func toKm(scale:Int16 = 2) -> String {
        
        let inputNumber = NSDecimalNumber(string: "\(Double(self)/1000.0)")
        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
        return "\(number)"
    }
}

//extension NSInteger {
//
//    public func toKm(scale:Int16 = 2) -> String {
//
//        let inputNumber = NSDecimalNumber(string: "\(Double(self)/1000.0)")
//        let number = inputNumber.rounding(accordingToBehavior: String.priceHandler(scale: scale))
//        return "\(number)"
//    }
//
//}
