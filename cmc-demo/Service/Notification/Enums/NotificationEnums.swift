//
//  NotificationEnums.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum NotificationEvent: String {
    case priceUpdate = "priceUpdate"
    case priceUpdateError = "priceUpdateError"
    case dismissKeyboard = "dismissKeyboard"
}

enum NotificationUIEvents: String {
    case cancel = "cancel"
    case confirm = "confirm"
    case enableConfirmView = "enableConfirmView"
    case disableConfirmView = "disableConfirmView"
}

