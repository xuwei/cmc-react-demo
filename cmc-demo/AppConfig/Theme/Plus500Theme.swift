//
//  DefaultTheme.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import Hex

struct Plus500Theme: AppThemeProtocol {

    var themeTitle: String { get { return "Plus500" } }
}

// MARK: fonts
extension Plus500Theme {
    
    var keyboardAppearance: UIKeyboardAppearance {
        get { return .light }
    }
    
    var statusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    var barStyle: UIBarStyle {
        get { return .default }
    }
    
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
extension Plus500Theme {
    var textColor: UIColor {
        get { return UIColor.init(hex: "ffffff")}
    }
    
    var altTextColor: UIColor {
        get { return UIColor.init(hex: "8e8e8e")}
    }
    
    var primaryColor: UIColor {
        get { return UIColor.init(hex: "0dbddc")}
    }
    
    var backgroundColor: UIColor {
        get { return UIColor.init(hex: "000000")}
    }
    
    var altTextBackgroundColor: UIColor {
        get { return UIColor.init(hex: "292a2b")}
    }
    
    var highlightColor: UIColor {
        get { return UIColor.init(hex: "0dbddc")}
    }
    
    var confirmColor: UIColor {
        get { return UIColor.init(hex: "0dbddc")}
    }
    
    var profitColor: UIColor {
        get { return UIColor.init(hex: "00d50e")}
    }
    
    var lossColor: UIColor {
        get { return UIColor.init(hex: "d60015")}
    }
    
    var buyColor: UIColor {
        get { return UIColor.init(hex: "03ddff")}
    }
    
    var sellColor: UIColor {
        get { return UIColor.init(hex: "f2991a")}
    }
    
    var navBgColor: UIColor {
        get { return UIColor.init(hex: "000000")}
    }
}

// MARK: gray system
extension Plus500Theme {
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
extension Plus500Theme {
    var longAnimationDuration: TimeInterval { return 1.0 }
    
    var mediumAnimationDuration: TimeInterval { return 0.5 }
    
    var quickAnimationDuration: TimeInterval { return 0.1}
}

// MARK: padding
extension Plus500Theme {
    var smallPadding: Double { get { return 10.0 } }
    
    var mediumPadding: Double { get { return 20.0 } }
    
    var largePadding: Double { get { return 40.0 } }
}

// MARK: disabled alpha
extension Plus500Theme {
    var nonActiveAlpha: CGFloat { get { return 0.5 } }
}

// MARK: styling
extension Plus500Theme {
    
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
