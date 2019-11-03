//
//  Date_Extension.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

extension Date {
    
    static let timeStampFormat = "dd/MM/yyyy hh:mm:ss a"
    
    func timeStamp()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.timeStampFormat
        let timeStamp = dateFormatter.string(from: self)
        return timeStamp
    }
    
    static func dateFromTimestamp(_ string: String)->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.timeStampFormat
        guard let date = dateFormatter.date(from: string) else { return nil }
        return date
    }
}
