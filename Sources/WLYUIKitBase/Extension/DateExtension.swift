//
//  Date.swift
//  Sky
//
//  Created by Mars on 06/03/2018.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit

extension Date {
    
    //MARK: - 获取日期各种值
        //MARK: 年
        public func year() ->Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year,.month,.day], from: self)
            return com.year!
        }
    
        //MARK: 月
        public func month() ->Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year,.month,.day], from: self)
            return com.month!
            
        }
        //MARK: 日
        public func day() ->Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year,.month,.day], from: self)
            return com.day!

        }
        //MARK: 星期几
        public func weekDay()->Int{
            let interval = Int(self.timeIntervalSince1970)
            let days = Int(interval/86400) // 24*60*60
            let weekday = ((days + 4)%7+7)%7
            return weekday == 0 ? 7 : weekday
        }
        //MARK: 当月天数
        public func countOfDaysInMonth() ->Int {
            let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
            let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
            return (range?.length)!

        }
        
    
    //MARK: - 老版本
    static func from(string: String) -> Date? {
        let dateFormatter = DateFormatter.yyyyMMdd()
        return dateFormatter.date(from: string)
    }

    
    /// 获取给定的时间 到当前的毫秒数
    /// - Parameter dateString: 时间
    /// - Returns: 返回
    public static func intervalDiff(dateString: String) -> NSInteger? {
        guard let date = Date.string2Date(dateString) else {
            return nil
        }
        
        let desInterval: NSInteger = NSInteger(date.timeIntervalSince1970*1000)
        
        let nowInterval: NSInteger = NSInteger(Date().timeIntervalSince1970*1000)
        
        return (desInterval - nowInterval)/1000
    }
    
    /// 将时间戳转为日期时间
    ///
    /// - Parameter timeStamp:
    /// - Returns:
    public static func timeStampToString(timeStamp: Int) -> String {

        //转换为时间
        let timeInterval: TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        //格式话输出
        let dformatter = DateFormatter.cicDefault(formatStr: "yyyy年MM月dd日 HH:mm:ss")
        return dformatter.string(from: date)
    }
    /// 获取当前时间戳 毫秒
    public static func timeStamp() -> NSInteger {
        let date = Date()
        let dateStamp: TimeInterval = date.timeIntervalSince1970*1000
        let timeStamp: NSInteger = NSInteger(dateStamp)
        return timeStamp
    }
    
    public static func stringToTimeStamp(stringTime: String) -> Int {

        let dfmatter = DateFormatter.yyyyMMddHHmm()
        let date = dfmatter.date(from: stringTime)

        let dateStamp: TimeInterval = date!.timeIntervalSince1970

        let dateSt: Int = Int(dateStamp)
        return dateSt

    }

    /// 获取当前时间的的字符串格式
    /// 往后延期的天数，默认是0 代表当前
    /// - Returns:
    public static func wlyCurrentDateString(afterDay:NSInteger = 0) -> String {
        //格式话输出
        let dformatter = DateFormatter.yyyyMMdd()
        let destindate = Date(timeInterval: TimeInterval(afterDay*24*60*60), since: Date())
        let timeStr: String = dformatter.string(from: destindate)
        return timeStr
    }
    
    //日期 -> 字符串
    public static func date2String(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter.cicDefault(formatStr: dateFormat)
        let date = formatter.string(from: date)
        return date
    }
    
    //字符串 -> 日期
    public static func string2Date(_ string: String, local: String = "", dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter.cicDefault(formatStr: dateFormat)
        if local != "" {
            formatter.locale = Locale(identifier: local)
        }
        let date = formatter.date(from: string)
        return date
    }
    /// 当前时间
    public static func nowString(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter.cicDefault(formatStr: dateFormat)
        return formatter.string(from: Date())
    }

}
/*
    服务器时间: "Sat, 09 May 2020 05:25:51 GMT"
    Date.string2Date(serverTime,local: "english",dateFormat: "EEE, dd MMMM yyyy HH:mm:ss Z")
 */

/*
    NSDateFormatter
     
    G:公元时代， 例如AD公元
     
    yy:年后的2位
     
    yyyy:完整年
     
    MM:月，显示为1-12
     
    MMM:月，显示为英文月分简写，如: Jan
     
    MMMM:月， 显示为英文月分全称,July
     
    dd:日， 2位数表示，如02
     
    d:日,1-2位显示， 如2
     
    EEE: 简写星期几，如Sun
     
    EEEE:全写星期几，如Sunday
     
    aa:上下午，AM/PM
     
    H:时，24小时制，0-23
     
    K:时，12小时制，0-11
     
    m:分，1-2位
     
    mm:分，2位
     
    s:秒，1-2位
     
    ss:秒: 2位
     
    S:毫秒
     
    Z:GMT
 */


extension Date {
    
    public func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    public static func dateTodate(date1:String,date2:String,format:String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter.cicDefault(formatStr: format)
        let startDate = formatter.date(from: date1)
        let endDate = formatter.date(from: date2)
        /// 当前日期 - 考试日期
        let days = startDate!.daysBetweenDate(toDate: endDate!)
        return "\(days)"
    }
    
    
    /// 从当前日期获取往前 n 个 月份的时间
    /// - Parameter n: n个月份
    /// - Returns: 返回时间数组
    public static func getDateYearMonths(n: NSInteger) -> [String] {
        
        var data: [String] = []
        //当前日期时间
        let currentDate = Date()
        //设定数据格式为xxxx-mm
        let formatter = DateFormatter.yyyyMM()
        //通过日历可以直接获取前几个月的日期，所以这里直接用该类的方法进行循环获取数据
        let calendar = Calendar(identifier: .gregorian)
        
        var lastMonthComps = DateComponents()
        var dateStr = formatter.string(from: currentDate)
        
        let lastIndex = -n
        
        var currentIndex = 0
        
        var newdate: Date?
        //循环获取可选月份，从当前月份到最小月份，直接用字符串的比较来判断是否大于设定的最小日期
        while currentIndex != lastIndex {
            data.append(dateStr)
            currentIndex -= 1
            //获取之前n个月, setMonth的参数为正则向后，为负则表示之前
            lastMonthComps.month = currentIndex
            newdate = calendar.date(byAdding: lastMonthComps, to: currentDate)
            if let newdate = newdate {
                dateStr = formatter.string(from: newdate)
            }else{
                currentIndex = lastIndex
            }
        }
        return data
    }
    
    /// 分割 时间字符串的 日月
    /// - Parameter date: yyyy-MM
    /// - Returns: (年，月)
    public static func dateSegmentationTool(date: String) -> (year: String, month: String)? {
        let dd = date.components(separatedBy: "-")
        if let y = dd.first, let m = dd[safe: 1] {
            return (y, m)
        }else{
            return nil
        }
    }
}

extension DateFormatter {
    
    /// 获取时间格式 默认全格式
    /// - Parameter formatStr:  yyyy-MM-dd HH:mm:ss
    /// - Returns: 返回时间格式
    static public func cicDefault(formatStr: String = "yyyy-MM-dd HH:mm:ss") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        formatter.timeZone = NSTimeZone.system
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.calendar = Calendar.init(identifier: .iso8601)
        return formatter
    }
    
    static public func yyyyMMddHHmm() -> DateFormatter {
        return DateFormatter.cicDefault(formatStr: "yyyy-MM-dd HH:mm")
    }
    
    static public func yyyyMMdd() -> DateFormatter {
        return DateFormatter.cicDefault(formatStr: "yyyy-MM-dd")
    }
    
    static public func yyyyMM() -> DateFormatter {
        return DateFormatter.cicDefault(formatStr: "yyyy-MM")
    }
    
    static public func HHmmss() -> DateFormatter {
        return DateFormatter.cicDefault(formatStr: "HH:mm:ss")
    }
}
