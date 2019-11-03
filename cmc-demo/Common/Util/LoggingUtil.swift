//
//  LoggingUtil.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class LoggingUtil {
    static let shared = LoggingUtil()
    private init() {}

    func cPrint(_ obj: Any) {
        print(obj)
        print(Date().timeStamp())
    }
}
