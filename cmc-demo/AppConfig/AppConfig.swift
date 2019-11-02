//
//  AppConfig.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class AppConfig {
    static let themes: [AppThemeProtocol] = [DefaultTheme(), NeonTheme()]
    static let shared = AppConfig()
    var activeTheme: AppThemeProtocol = DefaultTheme()
    var themeIndex: Int = 0
    
    private init() {
        
    }
    
    // to enable change of theme
    func updateTheme() {
        themeIndex = (themeIndex + 1) % AppConfig.themes.count
        self.activeTheme = AppConfig.themes[themeIndex]
    }
    
    func setupNavBarUI() {
        UINavigationBar.appearance().tintColor = AppConfig.shared.activeTheme.primaryColor
        UINavigationBar.appearance().backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = AppConfig.shared.activeTheme.backgroundColor

    }
}
