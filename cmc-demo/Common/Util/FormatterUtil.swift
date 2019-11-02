//
//  FormatterUtil.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class FormatterUtil {
    static let shared = FormatterUtil()
    let currencyFormatter = NumberFormatter()
    private init() {
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
    }

    func currencyFormat(_ value: Double)-> String {
        let price = currencyFormatter.string(from: NSNumber(value: value)) ?? ""
        return price
    }
}
