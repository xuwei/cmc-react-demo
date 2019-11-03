//
//  StringUtil.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class StringUtil {
    static let shared = StringUtil()
    private init() {}
    
    func isPositiveNumericOnly(_ string: String)-> Bool {
        let decimalPointIncluded = CharacterSet.decimalDigits.union (CharacterSet (charactersIn: "."))
        return !string.isEmpty && string.rangeOfCharacter(from: decimalPointIncluded.inverted) == nil
    }
}
