//
//  FormatterUtilTests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
@testable import cmc_demo

class FormatterUtilTests: XCTestCase {
    
    func testCurrencyFormatter() {
        
        let result1 = FormatterUtil.shared.currencyFormat(0.0)
        XCTAssertTrue(result1 == "$0.00")
        
        let result2 = FormatterUtil.shared.currencyFormat(100.0)
        XCTAssertTrue(result2 == "$100.00")
        
        let result3 = FormatterUtil.shared.currencyFormat(1000.0)
        XCTAssertTrue(result3 == "$1,000.00")
        
        let result4 = FormatterUtil.shared.currencyFormat(1000.0001)
        XCTAssertTrue(result4 == "$1,000.00")
        
        let result5 = FormatterUtil.shared.currencyFormat(1000.009)
        XCTAssertTrue(result5 == "$1,000.01")
        
        let result6 = FormatterUtil.shared.currencyFormat(1000.095)
        XCTAssertTrue(result6 == "$1,000.10")
        
        let result7 = FormatterUtil.shared.currencyFormat(1000.05)
        XCTAssertTrue(result7 == "$1,000.05")
        
        let result8 = FormatterUtil.shared.currencyFormat(999.99)
        XCTAssertTrue(result8 == "$999.99")
        
        let result9 = FormatterUtil.shared.currencyFormat(9999.99)
        XCTAssertTrue(result9 == "$9,999.99")
        
        let result10 = FormatterUtil.shared.currencyFormat(9999999.999)
        XCTAssertTrue(result10 == "$10,000,000.00")
        
        let result11 = FormatterUtil.shared.currencyFormat(9999999.99)
        XCTAssertTrue(result11 == "$9,999,999.99")
        
        let result12 = FormatterUtil.shared.currencyFormat(-9999999.99)
        XCTAssertTrue(result12 == "-$9,999,999.99")
        
        let result13 = FormatterUtil.shared.currencyFormat(-0.00001)
        XCTAssertTrue(result13 == "-$0.00")
    }
}
