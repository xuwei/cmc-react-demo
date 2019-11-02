//
//  DefaultTheme.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import Hex

struct NeonTheme: AppThemeProtocol {

    var themeTitle: String { get { return "Light" } }
}

// MARK: fonts
extension NeonTheme {
    var defaultFont: UIFont {
         get { return UIFont.systemFont(ofSize: 14.0) }
    }

    var mediumFont: UIFont {
        get { return UIFont.systemFont(ofSize: 18.0) }
    }

    var headerFont: UIFont {
        get { return UIFont.systemFont(ofSize: 24.0) }
    }
    
    var extraLargeFont: UIFont {
        get { return UIFont.systemFont(ofSize: 32.0)}
    }
}

// MARK: colors
extension NeonTheme {
    var textColor: UIColor {
        get { return UIColor.init(hex: "ffffff")}
    }
    
    var altTextColor: UIColor {
        get { return UIColor.init(hex: "ffffff")}
    }
    
    var primaryColor: UIColor {
        get { return UIColor.init(hex: "FF0DBE")}
    }
    
    var backgroundColor: UIColor {
        get { return UIColor.init(hex: "56386C")}
    }
    
    var altTextBackgroundColor: UIColor {
        get { return UIColor.init(hex: "540CE8")}
    }
    
    var highlightColor: UIColor {
        get { return UIColor.init(hex: "FFD100")}
    }
    
    var confirmColor: UIColor {
        get { return UIColor.init(hex: "9900FF")}
    }
    
    var profitColor: UIColor {
        get { return UIColor.init(hex: "78E80C")}
    }
    
    var lossColor: UIColor {
        get { return UIColor.init(hex: "FF00AB")}
    }
    
    var buyColor: UIColor {
        get { return UIColor.init(hex: "9900FF")}
    }
    
    var sellColor: UIColor {
        get { return UIColor.init(hex: "4FF09F")}
    }
}

// MARK: gray system
extension NeonTheme {
   var darkGrayColor: UIColor {
        get { return UIColor(hex: "111111") }
    }
    
    var mediumGrayColor: UIColor {
        get { return UIColor(hex: "333333") }
    }
    
    var lightGrayColor: UIColor {
        get { return UIColor(hex: "666666") }
    }
}

// MARK: animation 
extension NeonTheme {
    var longAnimationDuration: TimeInterval { return 1.0 }
    
    var mediumAnimationDuration: TimeInterval { return 0.5 }
    
    var quickAnimationDuration: TimeInterval { return 0.25}
}

// MARK: padding
extension NeonTheme {
    var smallPadding: Double { get { return 10.0 } }
    
    var mediumPadding: Double { get { return 20.0 } }
    
    var largePadding: Double { get { return 40.0 } }
}

// MARK: disabled alpha
extension NeonTheme {
    var nonActiveAlpha: CGFloat { get { return 0.5 } }
}

// MARK: styling
extension NeonTheme {
    
    var defaultButtonHeight: CGFloat { get { return 40.0 } }
    
    var defaultCornerRadius: CGFloat { get { return 20.0 } }
    
    func cardStyling(_ view: UIView, borderColor: UIColor?) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = AppConfig.shared.activeTheme.defaultCornerRadius
        if let color = borderColor {
            view.layer.borderWidth = 1.0
            view.layer.borderColor = color.cgColor
        }
    }
    
    func roundRectButton(_ button: inout UIButton) {
        button.layer.masksToBounds = false
        button.layer.cornerRadius = AppConfig.shared.activeTheme.defaultCornerRadius
        button.clipsToBounds = true
    }
}
