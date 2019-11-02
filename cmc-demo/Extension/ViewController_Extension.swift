//
//  ViewController_Extension.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter

protocol UIViewControllerProtocol {
    func baseScrollView()-> UIScrollView?
}

// MARK: BaseScrollView
extension UIViewController: UIViewControllerProtocol  {

    @objc func baseScrollView()-> UIScrollView? {
        return nil
    }
}

extension UIViewController {
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.baseScrollView() != nil, scrollView === self.baseScrollView(), scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setupKeyboardHandling() {

        // Event for programmatically dismissing the keyboard anywhere
        NotificationCenter.default.addObserver(self, selector: #selector(dismissKeyboard(notification:)), name: NSNotification.Name(NotificationEvent.dismissKeyboard.rawValue), object: nil)

        // Events from native keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if baseScrollView() == nil {
            keyboardWillShowWithoutScrollView(notification: notification)
        } else {
            keyboardWillShowWithScrollView(notification: notification)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if baseScrollView() == nil {
            keyboardWillHideWithoutScrollView()
        } else {
            keyboardWillHideWithScrollView()
        }
    }
    
    @objc func keyboardWillHideWithoutScrollView() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillShowWithoutScrollView(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHideWithScrollView() {
        guard let scrollView = self.baseScrollView() else { return }
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillShowWithScrollView(notification: NSNotification) {
        guard let scrollView = self.baseScrollView() else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset:UIEdgeInsets = scrollView.contentInset
            contentInset.bottom = keyboardSize.height
            scrollView.contentInset = contentInset
        }
    }

    @objc func dismissKeyboard(notification: NSNotification) {
        self.view.endEditing(true)
    }
    
    func tapToDismissKeyboard() {
        let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(notification:)))
        self.view.addGestureRecognizer(tapToDismissKeyboard)
    }
}
