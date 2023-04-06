//
//  File.swift
//  
//
//  Created by Laowang on 2023/4/4.
//

import Foundation

private class BundleFinder {}

extension Foundation.Bundle {
    
    static let i18n: Bundle = {
        let bundleName = "WLYUIKitBase_WLYUIKitBase"
        let bundleResourceURL = Bundle(for: BundleFinder.self).resourceURL
        let candidates = [
            Bundle.main.resourceURL,
            bundleResourceURL,
            Bundle.main.bundleURL,
            // Bundle should be present here when running previews from a different package "…/Debug-iphonesimulator/"
            bundleResourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            bundleResourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            // other Package
            bundleResourceURL?.deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            // 对于非 mac 苹果，可以需要使用 resources 尾缀
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
    
    /// Returns the resource bundle associated with the current Swift module.  会自动生成一个moudle
//    static let module1: Bundle = {
//        let bundleName = "WLYUIKitBase_WLYUIKitBase" // PackageName_TargetName
//
//        let overrides: [URL]
//#if DEBUG
//        if let override = ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_URL"] {
//            overrides = [URL(fileURLWithPath: override)]
//        } else {
//            overrides = []
//        }
//#else
//        overrides = []
//#endif
//
//        let candidates = overrides + [
//            // Bundle should be present here when the package is linked into an App.
//            Bundle.main.resourceURL,
//
//            // Bundle should be present here when the package is linked into a framework.
//            Bundle(for: BundleFinder.self).resourceURL,
//
//            // For command-line tools.
//            Bundle.main.bundleURL,
//        ]
//
//        for candidate in candidates {
//            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
//            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
//                return bundle
//            }
//        }
//        fatalError("unable to find bundle named BundleModuleDemo_BundleModuleDemo")
//    }()
}

