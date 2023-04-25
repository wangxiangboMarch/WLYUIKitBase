//
//  StringExtension.swift
//  U17
//
//  Created by charles on 2017/10/9.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}


extension String {
    
    /// 加解密用的方法:替换字符串某一个文字的字符
    public mutating func swapAtDe(index: NSInteger, c: Character) {
        let inde = self.index(self.startIndex, offsetBy: index)
        self.remove(at: inde)
        self.insert(c, at: inde)
    }

    /// Description 从某一位置开始截取到最后一位
    ///
    /// - Parameter index: index description  开始的位置
    /// - Returns: return value description 返回最后截取的字符串
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }

    /// Description 截取到某一位
    ///
    /// - Parameter index: index description 结束的位置
    /// - Returns: return value description 返回截取后的字符串
    public func substring(to index: Int) -> String {
        if self.count > index {
            let enIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<enIndex]
            return String(subString)
        } else {
            return self
        }
    }

    /// 把时间戳转换为时分秒的格式
    ///
    /// - Parameter seconds:
    /// - Returns:
    public func transformFormate() -> String {
        //转换为时间
        let timeInterval: TimeInterval = TimeInterval(Int(self)!)/1000
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        //格式话输出
        let dformatter = DateFormatter.HHmmss()
        return dformatter.string(from: date)
    }

    public func transformSecond() -> String {
        //转换为时间
        let timeInterval: Int = Int(self)!
        //格式话输出
        let hour: Int = timeInterval/3600
        var hourStr = "\(hour)"
        if hour < 10 {
            hourStr = "0\(hourStr)"
        }
        let min: Int = timeInterval%3600/60
        var minStr = "\(min)"
        if min < 10 {
            minStr = "0\(minStr)"
        }
        let second: Int = timeInterval%60
        var secondStr = "\(second)"
        if second < 10 {
            secondStr = "0\(secondStr)"
        }
        let str = "\(hourStr):\(minStr):\(secondStr)"
        return str

    }

    /// 获取当前日期是星期几
    public func getDayOfWeek() -> String {
        let formatter  = DateFormatter.yyyyMMdd()
        if let todayDate = formatter.date(from: self) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            switch weekDay {
            case 2 : return "星期一"
            case 3 : return "星期二"
            case 4 : return "星期三"
            case 5 : return "星期四"
            case 6 : return "星期五"
            case 7 : return "星期六"
            case 1 : return "星期日"
            default: return "bad week"
            }
        } else {
            return "bad week"
        }
    }
    
}

private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
    if str != nil {
        let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return strSize
    }

    if attriStr != nil {
        let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
        return strSize
    }

    return CGSize.zero

}

extension String {

    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    
    // 判断输入的字符串是否为数字，不含其它字符
    func isPurnFloat(string: String) -> Bool {

        let scan: Scanner = Scanner(string: string)

        var val: Float = 0

        return scan.scanFloat(&val) && scan.isAtEnd

    }

    /// 获取字符串高度H
    ///
    /// - Parameters:
    ///   - str: 字符
    ///   - strFont: 字体
    ///   - w: 跨度
    /// - Returns: 返回高度
    public func getNormalStrH(strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }

    /// 获取字符串宽
    ///
    /// - Parameters:
    ///   - str: 字符
    ///   - strFont: strFont description
    ///   - h: h description
    /// - Returns: return value description
    public func getNormalStrW(strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }

    /// Description获取富文本字符串高度H
    ///
    /// - Parameters:
    ///   - attriStr: attriStr description
    ///   - strFont: strFont description
    ///   - w: w description
    /// - Returns: return value description
    func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }

    /// 获取富文本字符串宽度W
    ///
    /// - Parameters:
    ///   - attriStr: attriStr description
    ///   - strFont: strFont description
    ///   - h: h description
    /// - Returns: return value description
    func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    /// 获取两个日期之间有多少天
    /// 默认格式 dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
    static public func getDays(startTime:String, endTime:String) -> String {
        
        let dfmatter = DateFormatter.cicDefault()
        //获取当前的时间戳
        guard let timeIntervalStart = dfmatter.date(from: startTime)?.timeIntervalSince1970 else { return "0天" }
        guard let timeIntervalEnd = dfmatter.date(from: endTime)?.timeIntervalSince1970 else { return "0天" }
        //时间差
        let reduceTime: TimeInterval = timeIntervalEnd - timeIntervalStart
        //时间差小于60秒
        if reduceTime < 60 {
            return "0天"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "0天"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "0天"
        }
        let days = Int(reduceTime / 3600 / 24)
        return "\(days)天"
    }
    
    // MARK: - 根据后台时间戳返回几分钟前，几小时前，几天前
    private static func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //        print(currentTime,   timeStamp, "sdsss")
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta: TimeInterval = TimeInterval(timeStamp)
        //时间差
        let reduceTime: TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }

        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter.yyyyMMddHHmm()
        let timeTime = dfmatter.string(from: date as Date)

        let days = Int(reduceTime / 3600 / 24)
        if days < 7 {
            let ww = currentTime.truncatingRemainder(dividingBy: 86400)
            let www = timeSta.truncatingRemainder(dividingBy: 86400)
            if ww <= www {
                return "\(days + 1)天前" + "  " + timeTime.suffix(5)
            }
            return "\(days)天前" + "  " + timeTime.suffix(5)
        }
        return timeTime
    }

    // MARK: - 时间转时间戳函数
    public static func timeToTimeStamp(time: String) -> Double {
        let dfmatter = DateFormatter.cicDefault()
        let last = dfmatter.date(from: time)
        let timeStamp = last?.timeIntervalSince1970
        return timeStamp ?? Date().timeIntervalSince1970
    }
    /// 时间变成b描述
    public func stringTimeToformat() -> String {
        let double = String.timeToTimeStamp(time: self)
        return String.updateTimeToCurrennTime(timeStamp: double)
    }
    /// 编码URL 中的汉字
    public func initPercent() -> String {
        
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        
        let urlwithPercentEscapes = self.addingPercentEncoding( withAllowedCharacters: charSet)
        return urlwithPercentEscapes ?? ""
    }
    /// 转换 range
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSRange(location: utf16view.distance(from: utf16view.startIndex, to: from), length: utf16view.distance(from: from, to: to))
        }
        return nil
    }

}

extension String {
    public func mToKmOrM() -> String {
        guard let d = Double(self) else {
            return "-米"
        }
        if d < 1000 {
            return String.init(format: "%.0f米", d)
        } else {
            return String.init(format: "%.2f公里", d/1000)
        }
    }
    
    public func toDateSimle() -> String {
        if self.count > 10 {
            return self.substring(to: 10)
        }
        return self
    }
}

extension StringProtocol {
    // 在Swift中将十六进制字符串转换为UInt8字节数组
    public var hexaData: Data { .init(hexa) }
    public var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}
