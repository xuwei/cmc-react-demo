//
//  CLabel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum LabelType {
    case normal
    case loss
    case profit
}

@IBDesignable
class CLabel: UILabel {
    
    var prevColor: UIColor = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        setupUI()
    }

    func setupUI() {
        self.textColor = AppConfig.shared.activeTheme.textColor
        self.prevColor = self.textColor
        self.font = AppConfig.shared.activeTheme.defaultFont
        self.backgroundColor = .clear
    }
}
