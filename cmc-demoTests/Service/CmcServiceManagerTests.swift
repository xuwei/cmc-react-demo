//
//  CmcServiceManagerTests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
@testable import cmc_demo

// integration testing
class CmcServiceManagerTests: XCTestCase {

    func testBlockchainTicker() {
        let expectation = XCTestExpectation(description: "testRemoteConfigBanks")
        
        let priceInfo = CmcServiceManager.shared.blockchainPrice(Currency.GBP.rawValue)
        XCTAssertTrue(priceInfo.symbol == "$")
        XCTAssertTrue(priceInfo.buy == 0.0)
        XCTAssertTrue(priceInfo.sell == 0.0)
        
        CmcServiceManager.shared.start()
        
        let delay = DispatchTime.now() + (CmcServiceManager.shared.blockchainPriceTickerPoll*1.5)
        // now we wait and check if we retrieve blockchainPrices after the wait
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            XCTAssertNotNil(CmcServiceManager.shared.blockchainPrices)
            let priceInfo = CmcServiceManager.shared.blockchainPrice(Currency.GBP.rawValue)
            
            XCTAssertTrue(priceInfo._15m ?? 0.0 > 0.0)
            XCTAssertTrue(priceInfo.buy ?? 0.0 > 0.0)
            XCTAssertTrue(priceInfo.sell ?? 0.0 > 0.0)
            XCTAssertTrue(priceInfo.last ?? 0.0 > 0.0)
            
            XCTAssertTrue(CmcServiceManager.shared.blockchainPrices.count > 0)
            XCTAssertTrue(CmcServiceManager.shared.blockchainPrices.count <= Currency.allSupported().count)
            
            for (currency, priceInfo) in CmcServiceManager.shared.blockchainPrices {
                XCTAssertTrue(currency.isEmpty == false)
                XCTAssertNotNil(priceInfo.symbol)
                XCTAssertNotNil(priceInfo._15m)
                XCTAssertNotNil(priceInfo.buy)
                XCTAssertNotNil(priceInfo.sell)
                XCTAssertNotNil(priceInfo.last)
            }
            
            // pass the expectation that we can retrieve data after an iteration of the polling period
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: XCTestConfig.shared.expectationWaitDuration)
    }
}
