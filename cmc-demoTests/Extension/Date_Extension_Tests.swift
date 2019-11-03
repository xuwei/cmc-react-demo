//
//  Date_Extension_Tests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
import DateToolsSwift
@testable import cmc_demo

class Date_Extension_Tests: XCTestCase {

    func testTimestamp() {
        let test1 = "01/01/1900 12:00:00 AM"
        // dd/MM/yyyy hh:mm:ss a
        let date = Date.dateFromTimestamp(test1)
        XCTAssertNotNil(date)
        let timeStamp = date?.timeStamp()
        XCTAssertNotNil(timeStamp)
        XCTAssertTrue(test1 == timeStamp)
        
        let test2 = "01/01/2900 12:00:00 PM"
        // dd/MM/yyyy hh:mm:ss a
        let date2 = Date.dateFromTimestamp(test2)
        XCTAssertNotNil(date2)
        let timeStamp2 = date2?.timeStamp()
        XCTAssertNotNil(timeStamp2)
        XCTAssertTrue(test2 == timeStamp2)
        
        let test3 = ""
        // dd/MM/yyyy hh:mm:ss a
        let date3 = Date.dateFromTimestamp(test3)
        XCTAssertNil(date3)
        
        // invalid date
        let test4 = "31/02/2900 12:00:00 PM"
        // dd/MM/yyyy hh:mm:ss a
        let date4 = Date.dateFromTimestamp(test4)
        XCTAssertNil(date4)
    }
}
