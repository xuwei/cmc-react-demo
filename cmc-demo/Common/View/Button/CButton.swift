//
//  CButton.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum CButtonType {
    case normal
    case confirm
}

@IBDesignable
class CButton: UIButton {
    
    var type: CButtonType = .normal

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: super.intrinsicContentSize.width, height: AppConfig.shared.activeTheme.defaultButtonHeight)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupUI()
    }
    
    func setupUI() {
        self.titleLabel?.textColor = AppConfig.shared.activeTheme.textColor
        self.titleLabel?.font = AppConfig.shared.activeTheme.defaultFont
        self.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        let button = self as UIView
        AppConfig.shared.activeTheme.cardStyling(button, borderColor: AppConfig.shared.activeTheme.lightGrayColor)
        self.alpha = self.isEnabled ? 1.0 : AppConfig.shared.activeTheme.nonActiveAlpha
        updateByType()
    }
    
    func updateByType() {
        switch self.type {
        case .normal:
            self.backgroundColor = AppConfig.shared.activeTheme.mediumGrayColor
            self.titleLabel?.textColor = AppConfig.shared.activeTheme.textColor
            self.setTitleColor(AppConfig.shared.activeTheme.textColor, for: .normal)
        case .confirm:
            self.backgroundColor = AppConfig.shared.activeTheme.confirmColor
            self.titleLabel?.textColor = AppConfig.shared.activeTheme.altTextColor
            self.setTitleColor(AppConfig.shared.activeTheme.textColor, for: .normal)
        }
    }
    
    // button style based on button type
    func setType(_ type: CButtonType) {
        self.type = type
        self.updateByType()
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled == false {
                self.alpha = AppConfig.shared.activeTheme.nonActiveAlpha
            } else {
                self.alpha = 1.0
            }
        }
    }
}
