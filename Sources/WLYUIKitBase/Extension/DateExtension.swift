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
//        public func year() ->Int {
//            let calendar = NSCalendar.current
//            let com = calendar.dateComponents([.year,.month,.day], from: self)
//            return com.year!
//        }
//
//        //MARK: 月
//        public func month() ->Int {
//            let calendar = NSCalendar.current
//            let com = calendar.dateComponents([.year,.month,.day], from: self)
//            return com.month!
//
//        }
//        //MARK: 日
//        public func day() ->Int {
//            let calendar = NSCalendar.current
//            let com = calendar.dateComponents([.year,.month,.day], from: self)
//            return com.day!
//
//        }
//        //MARK: 星期几
//        public func weekDay()->Int{
//            let interval = Int(self.timeIntervalSince1970)
//            let days = Int(interval/86400) // 24*60*60
//            let weekday = ((days + 4)%7+7)%7
//            return weekday == 0 ? 7 : weekday
//        }
//        //MARK: 当月天数
//        public func countOfDaysInMonth() ->Int {
//            let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//            let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
//            return (range?.length)!
//
//        }
        
    
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


//MARK: -

/// 时间戳的类型
public enum JKTimestampType: Int {
    /// 秒
    case second
    /// 毫秒
    case millisecond
}

// MARK: - 一、Date 基本的扩展
public extension Date {
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    /// 获取当前 秒级 时间戳 - 10 位
    static var secondStamp : String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    /// 获取当前 毫秒级 时间戳 - 13 位
    static var milliStamp : String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    // MARK: 1.3、获取当前的时间 Date
    /// 获取当前的时间 Date
    static var currentDate : Date {
        return Date()
    }
    
    // MARK: 1.4、从 Date 获取年份
    /// 从 Date 获取年份
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    // MARK: 1.5、从 Date 获取月份
    /// 从 Date 获取年份
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    // MARK: 1.6、从 Date 获取 日
    /// 从 Date 获取 日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // MARK: 1.7、从 Date 获取 小时
    /// 从 Date 获取 日
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    /// 从 Date 获取 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    // MARK: 1.9、从 Date 获取 秒
    /// 从 Date 获取 秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    // MARK: 1.10、从 Date 获取 毫秒
    /// 从 Date 获取 毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    // MARK: 1.11、从日期获取 星期(英文)
    /// 从日期获取 星期
    var weekday: String {
        jk_formatter.dateFormat = "EEEE"
        return jk_formatter.string(from: self)
    }
    
    // MARK: 1.12、从日期获取 星期(中文)
    var weekdayStringFromDate: String {
        let weekdays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self as Date)
        return  weekdays[theComponents.weekday! - 1]
    }
    
    // MARK: 1.13、从日期获取 月(英文)
    /// 从日期获取 月(英文)
    var monthAsString: String {
        jk_formatter.dateFormat = "MMMM"
        return jk_formatter.string(from: self)
    }
}

//MARK: - 二、时间格式的转换
// MARK: 时间条的显示格式
public enum JKTimeBarType {
    // 默认格式，如 9秒：09，66秒：01：06，
    case normal
    case second
    case minute
    case hour
}
public extension Date {
    
    // MARK: 2.1、时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串
    /// 时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - format: 格式
    /// - Returns: 对应时间的字符串
    static func timestampToFormatterTimeString(timestamp: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // 时间戳转为Date
        let date = timestampToFormatterDate(timestamp: timestamp)
        // let dateFormatter = DateFormatter()
        // 设置 dateFormat
        jk_formatter.dateFormat = format
        // 按照dateFormat把Date转化为String
        return jk_formatter.string(from: date)
    }
    
    // MARK: 2.2、时间戳(支持 10 位 和 13 位) 转 Date
    /// 时间戳(支持 10 位 和 13 位) 转 Date
    /// - Parameter timestamp: 时间戳
    /// - Returns: 返回 Date
    static func timestampToFormatterDate(timestamp: String) -> Date {
//        guard timestamp.count == 10 ||  timestamp.count == 13 else {
//            #if DEBUG
//            fatalError("时间戳位数不是 10 也不是 13")
//            #else
//            return Date()
//            #endif
//        }
//        guard let timestampInt = timestamp.jk.toInt() else {
//            #if DEBUG
//            fatalError("时间戳位有问题")
//            #else
//            return Date()
//            #endif
//        }
//        let timestampValue = timestamp.count == 10 ? timestampInt : timestampInt / 1000
//        // 时间戳转为Date
//        let date = Date(timeIntervalSince1970: TimeInterval(timestampValue))
//        return date
        return Date()
    }
    
    /// 根据本地时区转换
    private static func getNowDateFromatAnDate(_ anyDate: Date?) -> Date? {
        // 设置源日期时区
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
        // 或GMT
        // 设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        // 得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = anyDate {
            sourceGMTOffset = sourceTimeZone?.secondsFromGMT(for: aDate)
        }
        // 目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = anyDate {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        // 得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        // 转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = anyDate {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow
    }
    
    // MARK: 2.3、Date 转换为相应格式的时间字符串，如 Date 转为 2020-10-28
    /// Date 转换为相应格式的字符串，如 Date 转为 2020-10-28
    /// - Parameter format: 转换的格式
    /// - Returns: 返回具体的字符串
    func toformatterTimeString(formatter: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // let dateFormatter = DateFormatter()
        jk_formatter.timeZone = TimeZone.autoupdatingCurrent
        jk_formatter.dateFormat = formatter
        return jk_formatter.string(from: self)
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    /// 带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    /// - Parameters:
    ///   - timeString: 时间字符串，如：2020-10-26 16:52:41
    ///   - formatter: 时间格式，如：yyyy-MM-dd HH:mm:ss
    ///   - timestampType: 返回的时间戳类型，默认是秒 10 为的时间戳字符串
    /// - Returns: 返回转化后的时间戳
    static func formatterTimeStringToTimestamp(timesString: String, formatter: String, timestampType: JKTimestampType = .second) -> String {
        jk_formatter.dateFormat = formatter
        guard let date = jk_formatter.date(from: timesString) else {
            #if DEBUG
            fatalError("时间有问题")
            #else
            return ""
            #endif
        }
        if timestampType == .second {
            return "\(Int(date.timeIntervalSince1970))"
        }
        return "\(Int((date.timeIntervalSince1970) * 1000))"
    }
    
    // MARK: 2.5、带格式的时间转 Date
    /// 带格式的时间转 Date
    /// - Parameters:
    ///   - timesString: 时间字符串
    ///   - formatter: 格式
    /// - Returns: 返回 Date
    static func formatterTimeStringToDate(timesString: String, formatter: String) -> Date {
        jk_formatter.dateFormat = formatter
        guard let date = jk_formatter.date(from: timesString) else {
            #if DEBUG
            fatalError("时间有问题")
            #else
            return Date()
            #endif
        }
        /*
        guard let resultDate = getNowDateFromatAnDate(date) else {
            return Date()
        }
        */
        return date
    }
    
    // MARK: 2.6、秒转换成播放时间条的格式
    /// 秒转换成播放时间条的格式
    /// - Parameters:
    ///   - secounds: 秒数
    ///   - type: 格式类型
    /// - Returns: 返回时间条
    static func getFormatPlayTime(seconds: Int, type: JKTimeBarType = .normal) -> String {
        if seconds <= 0{
            return "00:00"
        }
        // 秒
        let second = seconds % 60
        if type == .second {
            return String(format: "%02d", seconds)
        }
        // 分钟
        var minute = Int(seconds / 60)
        if type == .minute {
            return String(format: "%02d:%02d", minute, second)
        }
        // 小时
        var hour = 0
        if minute >= 60 {
            hour = Int(minute / 60)
            minute = minute - hour * 60
        }
        if type == .hour {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        // normal 类型
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        if minute > 0 {
            return String(format: "%02d:%02d", minute, second)
        }
        return String(format: "%02d", second)
    }
    
    // MARK: 2.7、Date 转 时间戳
    /// Date 转 时间戳
    /// - Parameter timestampType: 返回的时间戳类型，默认是秒 10 为的时间戳字符串
    /// - Returns: 时间戳
    func dateToTimeStamp(timestampType: JKTimestampType = .second) -> String {
        // 10位数时间戳 和 13位数时间戳
        let interval = timestampType == .second ? CLongLong(Int(self.timeIntervalSince1970)) : CLongLong(round(self.timeIntervalSince1970 * 1000))
        return "\(interval)"
    }
    
    // 转成当前时区的日期
    func dateFromGMT() -> Date {
        let secondFromGMT: TimeInterval = TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        return self.addingTimeInterval(secondFromGMT)
    }
}

// MARK: - 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
public extension Date {
    
    // MARK: 3.1、今天的日期
    /// 今天的日期
    static let todayDate: Date = Date()
    
    // MARK: 3.2、昨天的日期（相对于date的昨天日期）
    /// 昨天的日期
    static var yesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: -1), to: Date())
    }
    
    // MARK: 3.3、明天的日期
    /// 明天的日期
    static var tomorrowDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: Date())
    }
    
    // MARK: 3.4、前天的日期
    /// 前天的日期
    static var theDayBeforYesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: -2), to: Date())
    }
    
    // MARK: 3.5、后天的日期
    /// 后天的日期
    static var theDayAfterYesterDayDate: Date? {
        return Calendar.current.date(byAdding: DateComponents(day: 2), to: Date())
    }
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    /// 是否为今天（只比较日期，不比较时分秒）
    /// - Returns: bool
    var isToday: Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date())
    }
    
    // MARK: 3.7、是否为昨天
    /// 是否为昨天
    var isYesterday: Bool {
        // 1.先拿到昨天的 date
        guard let date = Date.yesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    // MARK: 3.8、是否为前天
    /// 是否为前天
    var isTheDayBeforeYesterday: Bool  {
        // 1.先拿到前天的 date
        guard let date = Date.theDayBeforYesterDayDate else {
            return false
        }
        // 2.比较当前的日期和昨天的日期
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    // MARK: 3.9、是否为今年
    /// 是否为今年
    var isThisYear: Bool  {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
    
    // MARK: 3.10、两个date是否为同一天
    /// 是否为  同一年  同一月 同一天
    /// - Returns: bool
    func isSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    // MARK: 3.11、当前日期是不是润年
    /// 当前日期是不是润年
    var isLeapYear: Bool {
        let year = Date().year
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    /// 日期的加减操作
    /// - Parameter day: 天数变化
    /// - Returns: date
    private func adding(day: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day:day), to: self)
    }
    
    /// 是否为  同一年  同一月 同一天
    /// - Parameter date: date
    /// - Returns: 返回bool
    private func isSameYeaerMountDay(_ date: Date) -> Bool {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let comToday = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (com.day == comToday.day &&
            com.month == comToday.month &&
            com.year == comToday.year )
    }
    
    // MARK: 3.12、是否为本周
    /// 是否为本周
    /// - Returns: 是否为本周
    var isThisWeek: Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.weekday, .month, .year], from: Date())
        // self
        let selfComponents = calendar.dateComponents([.weekday,.month,.year], from: self as Date)
        return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.weekday == nowComponents.weekday)
    }
}

// MARK: - 四、相对的时间变化
public extension Date {
    
    // MARK: 4.1、取得与当前时间的间隔差
    /// 取得与当前时间的间隔差
    /// - Returns: 时间差
    func callTimeAfterNow() -> String {
        let timeInterval = Date().timeIntervalSince(self)
        if timeInterval < 0 {
            return "刚刚"
        }
        let interval = fabs(timeInterval)
        let i60 = interval / 60
        let i3600 = interval / 3600
        let i86400 = interval / 86400
        let i2592000 = interval / 2592000
        let i31104000 = interval / 31104000
        
        var time:String!
        if i3600 < 1 {
            let s = NSNumber(value: i60 as Double).intValue
            if s == 0 {
                time = "刚刚"
            } else {
                time = "\(s)分钟前"
            }
        } else if i86400 < 1 {
            let s = NSNumber(value: i3600 as Double).intValue
            time = "\(s)小时前"
        } else if i2592000 < 1 {
            let s = NSNumber(value: i86400 as Double).intValue
            time = "\(s)天前"
        } else if i31104000 < 1 {
            let s = NSNumber(value: i2592000 as Double).intValue
            time = "\(s)个月前"
        } else {
            let s = NSNumber(value: i31104000 as Double).intValue
            time = "\(s)年前"
        }
        return time
    }
    
    // MARK: 4.2、获取两个日期之间的数据
    /// 获取两个日期之间的数据
    /// - Parameters:
    ///   - date: 对比的日期
    ///   - unit: 对比的类型
    /// - Returns: 两个日期之间的数据
    func componentCompare(from date: Date, unit: Set<Calendar.Component> = [.year,.month,.day]) -> DateComponents {
        let calendar = Calendar.current
        let component = calendar.dateComponents(unit, from: date, to: Date())
        return component
    }
    
    // MARK: 4.3、获取两个日期之间的天数
    /// 获取两个日期之间的天数
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的天数
    func numberOfDays(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.day]).day
    }
    
    // MARK: 4.4、获取两个日期之间的小时
    /// 获取两个日期之间的小时
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的小时
    func numberOfHours(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.hour]).hour
    }
    
    // MARK: 4.5、获取两个日期之间的分钟
    /// 获取两个日期之间的分钟
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的分钟
    func numberOfMinutes(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.minute]).minute
    }
    
    // MARK: 4.6、获取两个日期之间的秒数
    /// 获取两个日期之间的秒数
    /// - Parameter date: 对比的日期
    /// - Returns: 两个日期之间的秒数
    func numberOfSeconds(from date: Date) -> Int? {
       return componentCompare(from: date, unit: [.second]).second
    }
}

// MARK: - 五、某年月份的天数获取
public extension Date {
    
    // MARK: 5.1、获取某一年某一月的天数
    /// 获取某一年某一月的天数
    /// - Parameters:
    ///   - year: 年份
    ///   - month: 月份
    /// - Returns: 返回天数
    static func daysCount(year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            let isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
            return isLeapYear ? 29 : 28
        default:
            fatalError("非法的月份:\(month)")
        }
    }
    
    // MARK: 5.2、获取当前月的天数
    /// 获取当前月的天数
    /// - Returns: 返回天数
    static func currentMonthDays() -> Int {
        return daysCount(year: Date.currentDate.year, month: Date.currentDate.month)
    }
}

/*
 DateFormatter 创建实例很耗时，如果多次创建 DateFormatter 实例，它可能会减慢app 响应速度，甚至更快地耗尽手机电池的电量。
 */
public let jk_formatter = DateFormatter()

// MARK: - 一、基本扩展
public extension DateFormatter {

    // MARK: 1.1、格式化快捷方式
    /// 格式化快捷方式
    /// - Parameter format: 格式
    convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}
