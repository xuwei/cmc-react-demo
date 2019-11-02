//
//  DefaultTheme.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import Hex

struct DefaultTheme: AppThemeProtocol {

    var themeTitle: String { get { return "CMC" } }
}

// MARK: fonts
extension DefaultTheme {
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
extension DefaultTheme {
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
}

// MARK: gray system
extension DefaultTheme {
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
extension DefaultTheme {
    var longAnimationDuration: TimeInterval { return 1.0 }
    
    var mediumAnimationDuration: TimeInterval { return 0.5 }
    
    var quickAnimationDuration: TimeInterval { return 0.25}
}

// MARK: padding
extension DefaultTheme {
    var smallPadding: Double { get { return 10.0 } }
    
    var mediumPadding: Double { get { return 20.0 } }
    
    var largePadding: Double { get { return 40.0 } }
}

// MARK: disabled alpha
extension DefaultTheme {
    var nonActiveAlpha: CGFloat { get { return 0.5 } }
}

// MARK: styling
extension DefaultTheme {
    
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
