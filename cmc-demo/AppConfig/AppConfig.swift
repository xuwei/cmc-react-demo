//
//  AppConfig.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class AppConfig {
    static let shared = AppConfig()
    var activeTheme: AppThemeProtocol = DefaultTheme()
    
    private init() {
    }
    
    // to enable change of theme
    func updateTheme(_ theme: AppThemeProtocol) {
        self.activeTheme = theme
    }
}
