//
//  UIViewController.swift
//  WLYUIKitBase
//
//  Created by wangxiangbo on 2020/8/26.
//

import UIKit
import AudioToolbox
import AVFoundation

extension UIViewController {
    /// Long vibration 长震动
    public func longVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    /// Long vibration 长震动
    public func longVibration(completion:(()->Void)?) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, completion)
    }
    
    /// Short vibration
    public func shortVibrationPeek() {
        AudioServicesPlaySystemSound(1519)
    }
    public func shortVibrationPop() {
        AudioServicesPlaySystemSound(1520)
    }
    /// 震动三次
    public func shortVibrationThree() {
        AudioServicesPlaySystemSound(1521)
    }
    /// 点击反馈
    public func feedbackGenerator() {
        let feedBackGenertor = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedBackGenertor.impactOccurred()
    }
    
    public func playSystemSound(resourceName:String? = nil,type:String? = nil) {
        var path = "/System/Library/Audio/UISounds/sms-received2.caf"
        if let resourceName = resourceName, let type = type {
            path = "/System/Library/Audio/UISounds/\(resourceName).\(type)"
        }
        
        guard let urlCF = URL(string: path) as CFURL? else {
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            print("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
    /// 播放本地声音
    public func playLocalSound(resourceName:String) {
        guard let urlCF = URL(string: resourceName) as CFURL? else {
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            print("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
    
}

extension UIView {
    /// Long vibration 长震动
    public func longVibration() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    /// Long vibration 长震动
    public func longVibration(completion:(()->Void)?) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, completion)
    }
    
    /// Short vibration
    public func shortVibrationPeek() {
        AudioServicesPlaySystemSound(1519)
    }
    public func shortVibrationPop() {
        AudioServicesPlaySystemSound(1520)
    }
    /// 震动三次
    public func shortVibrationThree() {
        AudioServicesPlaySystemSound(1521)
    }
    /// 点击反馈
    public func feedbackGenerator() {
        let feedBackGenertor = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedBackGenertor.impactOccurred()
    }
    
    public func playSystemSound(resourceName:String? = nil,type:String? = nil) {
        var path = "/System/Library/Audio/UISounds/sms-received2.caf"
        if let resourceName = resourceName, let type = type {
            path = "/System/Library/Audio/UISounds/\(resourceName).\(type)"
        }
        
        guard let urlCF = URL(string: path) as CFURL? else {
            return
        }
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
        AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
        {
            print("播放完成")
            // 三. 释放资源
            AudioServicesDisposeSystemSoundID(systemSoundID)

        }
    }
}
