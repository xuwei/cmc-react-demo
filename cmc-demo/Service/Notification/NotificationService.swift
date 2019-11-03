//
//  NotificationService.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter

class NotificationService {
    static let shared = NotificationService()
    private init() {
    }
    
    func notify(_ name: String, key: String, object: Any!) {
        var dataDict:[String: Any] = [:]
        if object != nil {
            dataDict = [key: object]
        }
        NotificationCenter.default.post(name: Notification.Name(name), object: nil, userInfo: dataDict)
    }
    
    func notifyError(error: Error) {
        LoggingUtil.shared.cPrint("notifyError")
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.priceUpdateError.rawValue), object: error)
    }
    
    func notifyPrices(prices: [String: PriceInfo]) {
        let dataDict = prices
        LoggingUtil.shared.cPrint("notifyPrices")
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.priceUpdate.rawValue), object: nil, userInfo: dataDict)
    }
    
    func notifyKeyboardDismiss() {
        LoggingUtil.shared.cPrint("notifyKeyboardDismiss")
        NotificationCenter.default.post(name: Notification.Name(NotificationEvent.dismissKeyboard.rawValue), object: nil, userInfo: nil)
    }
}
