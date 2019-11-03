//
//  DefaultTheme.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import Hex

struct IGTradingTheme: AppThemeProtocol {

    var themeTitle: String { get { return "IG" } }
}

// MARK: fonts
extension IGTradingTheme {
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
extension IGTradingTheme {
    
    var keyboardAppearance: UIKeyboardAppearance {
        get { return .light }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    var barStyle: UIBarStyle {
        get { return .default }
    }
    
    var textColor: UIColor {
        get { return UIColor.init(hex: "34333C")}
    }
    
    var altTextColor: UIColor {
        get { return UIColor.init(hex: "000000")}
    }
    
    var primaryColor: UIColor {
        get { return UIColor.init(hex: "B72122")}
    }
    
    var backgroundColor: UIColor {
        get { return UIColor.init(hex: "efefef")}
    }
    
    var altTextBackgroundColor: UIColor {
        get { return UIColor.init(hex: "EBEBED")}
    }
    
    var highlightColor: UIColor {
        get { return UIColor.init(hex: "0D94D3")}
    }
    
    var confirmColor: UIColor {
        get { return UIColor.init(hex: "00d50e")}
    }
    
    var profitColor: UIColor {
        get { return UIColor.init(hex: "78E80C")}
    }
    
    var lossColor: UIColor {
        get { return UIColor.init(hex: "FF00AB")}
    }
    
    var buyColor: UIColor {
        get { return UIColor.init(hex: "0D94D3")}
    }
    
    var sellColor: UIColor {
        get { return UIColor.init(hex: "DC3A35")}
    }
    
    var navBgColor: UIColor {
        get { return UIColor.init(hex: "B72122")}
    }
    
    var navTintColor: UIColor {
        get { return UIColor.init(hex: "ffffff")}
    }
    
    var navTitleColor: UIColor {
        get { return UIColor.init(hex: "ffffff")}
    }
}

// MARK: gray system
extension IGTradingTheme {
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
extension IGTradingTheme {
    var longAnimationDuration: TimeInterval { return 1.0 }
    
    var mediumAnimationDuration: TimeInterval { return 0.5 }
    
    var quickAnimationDuration: TimeInterval { return 0.1}
}

// MARK: padding
extension IGTradingTheme {
    var smallPadding: Double { get { return 10.0 } }
    
    var mediumPadding: Double { get { return 20.0 } }
    
    var largePadding: Double { get { return 40.0 } }
}

// MARK: disabled alpha
extension IGTradingTheme {
    var nonActiveAlpha: CGFloat { get { return 0.5 } }
}

// MARK: styling
extension IGTradingTheme {
    
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
