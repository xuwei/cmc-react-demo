//
//  CPopupDialog.swift
//  Cheq
//
//  Created by Xuwei Liang on 9/9/19.
//  Copyright © 2019 Cheq. All rights reserved.
//

import PopupDialog

enum CPopupDialogTitle: String {

    case decision = "Are you sure?"
    case message = "Message"
    case error = "Error"
    case congrats = "Congradulations!"
}

enum CPopupDialogButton: String {
    case ok = "OK"
    case cancel = "Cancel"
}

class CPopupDialog {

    let messageTitle: String
    let messageBody: String
    var imageName: String = ""
    let buttonTitle: String
    let cancelButtonTitle: String
    var popup: PopupDialog
    
    init(_ messageTitle: CPopupDialogTitle, image: String, messageBody: String, button: CPopupDialogButton, completion: @escaping ()->Void) {
        self.messageTitle = messageTitle.rawValue
        self.imageName = image
        self.messageBody = messageBody
        self.buttonTitle = button.rawValue
        self.cancelButtonTitle = ""
        self.popup = PopupDialog(title: self.messageTitle, message: self.messageBody, image: UIImage(named: image), buttonAlignment: .horizontal, transitionStyle: .fadeIn, preferredWidth: UIScreen.main.bounds.size.width, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        setupUI(&popup)
        // Create buttons
        let buttonOne = CancelButton(title: self.buttonTitle) {
            completion()
        }
        popup.addButton(buttonOne)
    }
    
    init(_ messageTitle: CPopupDialogTitle, messageBody: String, button: CPopupDialogButton, cancelButton: CPopupDialogButton, confirm: @escaping ()->Void, cancel: @escaping ()-> Void) {
        self.messageTitle = messageTitle.rawValue
        self.messageBody = messageBody
        self.buttonTitle = button.rawValue
        self.cancelButtonTitle = cancelButton.rawValue
        self.popup = PopupDialog(title: self.messageTitle, message: self.messageBody, image: nil, buttonAlignment: .horizontal, transitionStyle: .fadeIn, preferredWidth: UIScreen.main.bounds.size.width * 0.8, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        setupUI(&popup)
        // Create buttons
        let confirmButton = DefaultButton(title: self.buttonTitle) {
            confirm()
        }
        
        let cancelButton = CancelButton(title: self.cancelButtonTitle) {
            cancel()
        }
        popup.addButton(confirmButton)
        popup.addButton(cancelButton)
    }
    
    init(_ messageTitle: CPopupDialogTitle, messageBody: String, button: CPopupDialogButton, completion: @escaping ()->Void) {
        self.messageTitle = messageTitle.rawValue
        self.messageBody = messageBody
        self.buttonTitle = button.rawValue
        self.cancelButtonTitle = ""
        self.popup = PopupDialog(title: self.messageTitle, message: self.messageBody)
        self.popup.transitionStyle = .fadeIn
        setupUI(&popup)
        // Create buttons
        let buttonOne = CancelButton(title: self.buttonTitle) {
            completion()
        }
        popup.addButton(buttonOne)
        
    }

    func setupUI(_ popup: inout PopupDialog) {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor      = AppConfig.shared.activeTheme.backgroundColor
        dialogAppearance.titleFont            = AppConfig.shared.activeTheme.headerFont
        dialogAppearance.titleColor           = AppConfig.shared.activeTheme.primaryColor
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = AppConfig.shared.activeTheme.defaultFont
        dialogAppearance.messageColor         = AppConfig.shared.activeTheme.primaryColor
        dialogAppearance.messageTextAlignment = .left
        
        let buttonAppearance = CancelButton.appearance()
        // Cancel button
        buttonAppearance.titleFont      = AppConfig.shared.activeTheme.mediumFont
        buttonAppearance.titleColor     = AppConfig.shared.activeTheme.primaryColor
        buttonAppearance.buttonColor    = AppConfig.shared.activeTheme.backgroundColor
        buttonAppearance.separatorColor = AppConfig.shared.activeTheme.primaryColor
        
        let defaultButtonAppearance = DefaultButton.appearance()
        // Default button
        defaultButtonAppearance.titleFont      = AppConfig.shared.activeTheme.mediumFont
        defaultButtonAppearance.titleColor     = AppConfig.shared.activeTheme.primaryColor
        defaultButtonAppearance.buttonColor    = AppConfig.shared.activeTheme.backgroundColor
        defaultButtonAppearance.separatorColor = AppConfig.shared.activeTheme.primaryColor
        
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = Float(AppConfig.shared.activeTheme.defaultCornerRadius)
    }
    
    func present(_ viewController: UIViewController) {
        viewController.present(popup, animated: true, completion: nil)
    }

}
