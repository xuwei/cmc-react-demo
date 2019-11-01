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
    var activeTheme = DefaultTheme()
    
    private init() {
    }
}
