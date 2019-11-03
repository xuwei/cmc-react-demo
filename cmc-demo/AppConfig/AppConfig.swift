//
//  AppConfig.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum ThemeName: String {
    case cmc = "CMC"
    case ig = "IG"
    case plus500 = "plus500"
}

struct Theme {
    let name: ThemeName
    let themeImpl: AppThemeProtocol
}

class AppConfig {
    static let themes: [Theme] = [Theme(name: .cmc, themeImpl: DefaultTheme()), Theme(name: .ig, themeImpl: IGTradingTheme()), Theme(name: .plus500, themeImpl: Plus500Theme())]
    static let shared = AppConfig()
    var activeTheme: AppThemeProtocol = DefaultTheme()
    var themeIndex: Int = 0
    
    private init() {
        
    }
    
    // to enable change of theme
    func updateTheme(_ index: Int) {
        let theme = AppConfig.themes[index]
        self.activeTheme = theme.themeImpl
    }
    
    func setupNavBarUI() {
        UINavigationBar.appearance().tintColor = AppConfig.shared.activeTheme.primaryColor
        UINavigationBar.appearance().backgroundColor = AppConfig.shared.activeTheme.navBgColor
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : AppConfig.shared.activeTheme.highlightColor]
        UINavigationBar.appearance().barTintColor = AppConfig.shared.activeTheme.backgroundColor
    }
    
    func setupNavBarUI(_ viewController: UIViewController) {
        guard let nav = viewController.navigationController else { return }
        let navBar = nav.navigationBar
        navBar.tintColor = AppConfig.shared.activeTheme.textColor
        navBar.backgroundColor = AppConfig.shared.activeTheme.navBgColor
        navBar.isTranslucent = true
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : AppConfig.shared.activeTheme.highlightColor]
        navBar.barTintColor = AppConfig.shared.activeTheme.navBgColor
    }
}
