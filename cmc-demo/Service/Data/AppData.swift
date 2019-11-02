//
//  AppData.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import Foundation

class AppData {
    static let shared = AppData()

    private init() {
    }
    
    // centralising the current state for various aspect of the app
    var currentCurrency: Currency = .GBP
    var tradeType: TradeType = .buy
    
    // this is updated by CmcServiceManager
    var lastRefreshed: String = Date().timeStamp()
}
