//
//  UIViewExtension.swift
//  U17
//
//  Created by charles on 2017/11/13.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Description 添加阴影 to View
    /// - Parameters:
    ///   - sColor: sColor description
    ///   - offset: offset description
    ///   - opacity: opacity description
    ///   - radius: radius description
    public func setShadow(sColor: UIColor = UIColor.gray,
                   offset: CGSize = CGSize(width: 0.0, height: 0.0),
                   opacity: Float = 0.5,
                   radius: CGFloat = 3) {
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
        // 默认nil，系统自动配置
//        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: self.bounds.origin.x - offset.width,
//                                                          y: self.bounds.origin.y - offset.height,
//                                                          width: self.bounds.width + offset.width*2,
//                                                          height: self.bounds.height + offset.height*2)).cgPath
    }

    /// Description 添加阴影 to View (高性能)
    /// - Parameters:
    ///   - sColor: sColor description
    ///   - offset: offset description
    ///   - opacity: opacity description
    ///   - radius: radius description
    public func setShadowNormal(sColor: UIColor = UIColor.gray,
                   offset: CGSize = CGSize(width: 0.0, height: 0.0),
                   opacity: Float = 0.5,
                   radius: CGFloat = 3) {
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        
//        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: self.bounds.origin.y+offset.width, y: imageView.bounds.origin.y+offset.height, width: <#T##CGFloat#>, height: <#T##CGFloat#>), cornerRadius: radius).cgPath
//        
//
//        //设置阴影半径
        self.layer.shadowRadius = radius
//        //设置阴影偏移量
        self.layer.shadowOffset = offset
//        // 默认nil，系统自动配置
////        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        imageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(imageView.bounds.origin.x+5, imageView.bounds.origin.y+5, imageView.bounds.size.width, imageView.bounds.size.height)] CGPath];
//        imageView.layer.shadowOpacity = 0.6;
//
//        imageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//        imageView.layer.shadowRadius = 5.0f;
//        imageView.layer.shadowOpacity = 0.6;
    }
    
    
    
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }

    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    class BlurView {

        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?

        var animationDuration: TimeInterval = 0.1

        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }

        init(to view: UIView) {
            self.superview = view
        }

        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true

            self.style = style
            self.alpha = alpha

            self.editing = false

            return self
        }

        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }

            self.blur?.isHidden = isHidden
        }

        private func applyBlurEffect() {
            blur?.removeFromSuperview()

            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }

        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear

            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)

            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)

            blurEffectView.alpha = blurAlpha

            superview.insertSubview(blurEffectView, at: 0)

            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()

            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }

    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }

    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
}

public protocol LayoutGuideProvider {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}
extension UILayoutGuide: LayoutGuideProvider {}

public class CustomLayoutGuide: LayoutGuideProvider {
    public let topAnchor: NSLayoutYAxisAnchor
    public let bottomAnchor: NSLayoutYAxisAnchor
    init(topAnchor: NSLayoutYAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
        self.topAnchor = topAnchor
        self.bottomAnchor = bottomAnchor
    }
}

extension UIViewController {
    @objc public var layoutInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return UIEdgeInsets(top: topLayoutGuide.length,
                                left: 0.0,
                                bottom: bottomLayoutGuide.length,
                                right: 0.0)
        }
    }

    public var layoutGuide: LayoutGuideProvider {
        if #available(iOS 11.0, *) {
            return view!.safeAreaLayoutGuide
        } else {
            return CustomLayoutGuide(topAnchor: topLayoutGuide.bottomAnchor,
                                     bottomAnchor: bottomLayoutGuide.topAnchor)
        }
    }
}

protocol SideLayoutGuideProvider {
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
}

extension UIView: SideLayoutGuideProvider {}
extension UILayoutGuide: SideLayoutGuideProvider {}

// The reason why UIView has no extensions of safe area insets and top/bottom guides
// is for iOS10 compat.
extension UIView {
    var sideLayoutGuide: SideLayoutGuideProvider {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            return self
        }
    }

    var presentationFrame: CGRect {
        return layer.presentation()?.frame ?? frame
    }
}

extension UIView {
    func disableAutoLayout() {
        let frame = self.frame
        translatesAutoresizingMaskIntoConstraints = true
        self.frame = frame
    }
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    static func performWithLinear(startTime: Double = 0.0, relativeDuration: Double = 1.0, _ animations: @escaping (() -> Void)) {
        UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: relativeDuration, animations: animations)
        }, completion: nil)
    }
}

extension UIView {
    /// 圆角
    public func setCorners(corners:UIRectCorner,corner:CGFloat = 5) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}



