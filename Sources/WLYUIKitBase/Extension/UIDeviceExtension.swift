//
//  UIDevice+Extension.swift
//  U17
//
//  Created by charles on 2017/10/27.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import WLYUIKitBaseOC

public extension UIDevice {

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"

        case "iPhone11,2":               return "iPhone XS"
        case "iPhone11,6":               return "iPhone XS Max"
        case "iPhone11,8":               return "iPhone XR"

        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"

        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1", "AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"

        case "i386", "x86_64":  return "Simulator"

        default:  return identifier
        }
    }
}


extension UIDevice {
    /*
     *  设备信息
     */
    /// 屏蔽API时候的的 API 版本号
    static public func versionCode() -> String {
        return (Bundle.main.infoDictionary!["CFBundleVersion"] as? String) ?? "6"
    }

    /// 获取iPhone名称
    static public func iphoneName() -> String {
        return UIDevice.current.name
    }

    /// 获取app版本号
    static public func appVersion() -> String {
        return (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String) ?? "--"
    }

    /// 获取电池电量
    static public func batteryLevel() -> CGFloat {
        return CGFloat(UIDevice.current.batteryLevel)
    }

    /// 当前系统名称
    static public func systemName() -> String {
        return UIDevice.current.systemName
    }

    /// 当前系统版本号
    static public func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    /// 通用唯一识别码UUID
    static public func UUID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }

    /// 获取当前设备IP
    func deviceIP() -> String? {
        var addresses = [String]()
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }

    /// 私有方法
    //private func blankof<T>(type:T.Type) -> T {
    //    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
    //    let val = ptr.pointee
    //    ptr.deinitialize(count: 0)
    //    return val
    //}

    /// 获取总内存大小
    //func totalRAM() -> Int64 {
    //    var fs = blankof(type: statfs.self)
    //    if statfs("/var",&fs) >= 0{
    //        return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
    //    }
    //    return -1
    //}

    /// 获取当前可用内存
    //func availableRAM() -> Int64 {
    //    var fs = blankof(type: statfs.self)
    //    if statfs("/var",&fs) >= 0{
    //        return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
    //    }
    //    return -1
    //}

    /// 获取电池当前的状态，共有4种状态
    func batteryState() -> String {
        let device = UIDevice.current
        if device.batteryState == UIDevice.BatteryState.unknown {
            return "unknown"
        } else if device.batteryState == UIDevice.BatteryState.unplugged {
            return "unplugged"
        } else if device.batteryState == UIDevice.BatteryState.charging {
            return "charging"
        } else if device.batteryState == UIDevice.BatteryState.full {
            return "full"
        }
        return ""
    }

    /// 获取当前语言
    func deviceLanguage() -> String {
        return Locale.preferredLanguages[0]
    }
    /// 唯一UUID
    static public func uniqueUUID() -> String {
        var uuid = ""
        if PDKeyChain.keyChainLoad() != nil {
            uuid = PDKeyChain.keyChainLoad()
        } else {
            PDKeyChain.keyChainSave(UIDevice.UUID())
            uuid = PDKeyChain.keyChainLoad()
        }
        uuid = uuid.replacingOccurrences(of: "-", with: "")
        /// 存起来
        return uuid
    }
}
