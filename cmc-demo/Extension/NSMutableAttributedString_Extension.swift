//
//  NSMutableAttributedString_Extension.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    // applying different font for currency value like "$1,000.00", "$9.95", etc
    func applyCustomFontsOnDecimals(_ color: UIColor, font: UIFont) {
        let decimal = CharacterSet (charactersIn: ".")
        let range = self.mutableString.rangeOfCharacter(from: decimal)
        let rangeToUpdate = NSRange(location: range.lowerBound, length: self.mutableString.length - range.lowerBound)
        if range.location != NSNotFound {
            self.addAttribute(.foregroundColor, value: color , range: rangeToUpdate)
            self.addAttribute(.font, value: font, range: rangeToUpdate )
        }
    }
}
