//
//  StringUtilTests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
@testable import cmc_demo

class StringUtilTests: XCTestCase {

    func testIsNumericOnlyPositive() {
        XCTAssertTrue(StringUtil.shared.isPositiveNumericOnly("0123456789."))
        XCTAssertTrue(StringUtil.shared.isPositiveNumericOnly("1"))
        XCTAssertTrue(StringUtil.shared.isPositiveNumericOnly("1000000"))
        XCTAssertTrue(StringUtil.shared.isPositiveNumericOnly("1.23456789"))
        XCTAssertTrue(StringUtil.shared.isPositiveNumericOnly("0.00000001"))
    }
    
    func testIsNumericOnlyNegative() {
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly("1,000.00"))
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly("-1"))
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly("abc"))
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly(" "))
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly(" 123"))
        XCTAssertFalse(StringUtil.shared.isPositiveNumericOnly("$10.00"))
    }
}
