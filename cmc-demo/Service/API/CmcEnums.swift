//
//  CmcEnums.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum Currency: String, CaseIterable {
    case USD = "USD"
    case AUD = "AUD"
    case BRL = "BRL"
    case CAD = "CAD"
    case CHF = "CHF"
    case CLP = "CLP"
    case CNY = "CNY"
    case DKK = "DKK"
    case EUR = "EUR"
    case GBP = "GBP"
    case HKD = "HKD"
    case INR = "INR"
    case ISK = "ISK"
    case JPY = "JPY"
    case KRW = "KRW"
    case NZD = "NZD"
    case PLN = "PLN"
    case RUB = "RUB"
    case SEK = "SEK"
    case SGD = "SGD"
    case THB = "THB"
    case TWD = "TWD"
    
    static func allSupported()->[Currency] {
        return [.USD, .AUD, .GBP, .HKD, .SGD, .EUR]
    }
}
