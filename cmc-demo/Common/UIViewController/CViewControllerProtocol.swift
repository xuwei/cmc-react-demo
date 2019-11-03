//
//  CViewControllerProtocol.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter

protocol CViewControllerProtocol {
    func addObservables()
    func setupUI()
    
    // objc so that we can trigger it by notification with #selector reference
    func updateUI(_ notification: NSNotification)
}
