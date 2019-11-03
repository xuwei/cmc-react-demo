//
//  XCTestConfig.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class XCTestConfig {
    static let shared = XCTestConfig()
    let expectationWaitDuration = 60.0
    private init() {}
}
