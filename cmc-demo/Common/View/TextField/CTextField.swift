//
//  CTextField.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum CTextFieldState {
    case normal
    case active
}

@IBDesignable
class CTextField: UITextField {
    
    var textFieldState: CTextFieldState = .normal
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }
       
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupUI()
   }
    
   func setupUI() {
       UITextField.appearance().keyboardAppearance = .dark
    self.backgroundColor = .orange
       self.font = AppConfig.shared.activeTheme.defaultFont
       self.textColor = AppConfig.shared.activeTheme.textColor
       let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: AppConfig.shared.activeTheme.mediumPadding, height: Double(AppConfig.shared.activeTheme.defaultButtonHeight)))
       self.leftView = paddingView
       self.leftViewMode = .always
       self.rightView = paddingView
       self.rightViewMode = .always
       AppConfig.shared.activeTheme.cardStyling(self, borderColor: AppConfig.shared.activeTheme.lightGrayColor)
    
        self.attributedPlaceholder = NSAttributedString(string: "placeholder text",
                                                        attributes: [NSAttributedString.Key.foregroundColor: AppConfig.shared.activeTheme.lightGrayColor])
        updateByType()
   }
    
    override open var intrinsicContentSize: CGSize {
       get {
           return CGSize(width: super.intrinsicContentSize.width, height: AppConfig.shared.activeTheme.defaultButtonHeight)
       }
    }
    
    override func prepareForInterfaceBuilder() {
        setupUI()
    }
    
    func updateByType() {
        switch self.textFieldState {
        case .normal:
            self.layer.borderColor = AppConfig.shared.activeTheme.lightGrayColor.cgColor
        case .active:
            self.layer.borderColor = AppConfig.shared.activeTheme.highlightColor.cgColor
        }
    }
    
     // button style based on button type
    func setTextFieldState(_ type: CTextFieldState) {
        self.textFieldState = type
        updateByType()
    }
}
