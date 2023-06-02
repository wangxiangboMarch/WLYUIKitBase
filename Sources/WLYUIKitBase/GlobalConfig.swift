//
//  GlobalConfig.swift
//  WLYUIKit
//
//  Created by ZHXMAC on 2019/9/5.
//  Copyright © 2019 ZHXMAC. All rights reserved.
//

import Foundation
import UIKit

public struct GConfig {
    
    public static let ScreenW = UIScreen.main.bounds.width
    public static let ScreenH = UIScreen.main.bounds.height
    
    public static let NavigationBarH: CGFloat = isFullScreen() ? 88 : 64
    public static let BottomSafeH: CGFloat = isFullScreen() ? 34 : 0
    public static let TopSafeH: CGFloat = isFullScreen() ? 44 : 20
    
    public static let NavAndBottomBarH = NavigationBarH + BottomSafeH
    
    // MARK: print
    public static func log<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
        #endif
    }
    
    static func isFullScreen() -> Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return false
            }
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                print(unwrapedWindow.safeAreaInsets)
                return true
            }
        }
        return false
    }
    public static let userDefault = UserDefaults.standard
}




// MARK: - stackView
public protocol StackViewControllerProtocol: UIViewController {
    var scrollView: UIScrollView { get set }
    var stackView: UIStackView { get set }
}

extension StackViewControllerProtocol {
    
    /// 添加子视图
    /// - Parameters:
    ///   - child: 子视图
    ///   - size: 子视图的大小
    public func add(_ child: UIView, size: CGSize) {
        stackView.addArrangedSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        if size.height != 0 {
            child.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0 {
            child.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
    }
    
    /// 移除子视图
    /// - Parameter child: 子视图
    public func remove(_ child: UIView) {
        stackView.removeArrangedSubview(child)
        child.removeFromSuperview()
    }
    
    /// 移除所有子视图
    public func removeAll() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    /// 初始化滚动视图
    @available(iOS 11.0, *)
    public func setUpStackAndScrollView(insets: UIEdgeInsets = UIEdgeInsets.zero) {
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.backGroundColor()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(stackView)
        setupConstraints(insets: insets)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
    }
    
    
    @available(iOS 11.0, *)
    private func setupConstraints(insets: UIEdgeInsets) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(insets.left + insets.right))
            ])
    }
}
