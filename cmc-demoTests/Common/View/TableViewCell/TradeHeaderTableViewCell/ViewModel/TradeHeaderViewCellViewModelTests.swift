//
//  TradeHeaderViewCellViewModelTests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
@testable import cmc_demo

// creating a mock object to override the price fetching code for our testing purpose
class TradeHeaderViewCellViewModelMock: TradeHeaderViewCellViewModel {
    
    var buy: Double = 1200.00
    var sell: Double = 900.00
    
    override func price()->PriceInfo {
        return PriceInfo(_15m: 1000.00, last: 1000.00, buy: self.buy, sell: self.sell, symbol: "$")
    }
}

class TradeHeaderViewCellViewModelTests: XCTestCase {

    func testCalculateSpread() {
        let viewModel = TradeHeaderViewCellViewModelMock()
        viewModel.buy = 1200.00
        viewModel.sell = 900.00
        XCTAssertTrue(viewModel.calculateSpread() == 300.0)
        
        viewModel.buy = 1000.00
        viewModel.sell = 1200.00
        XCTAssertTrue(viewModel.calculateSpread() == -200.0)
        
        viewModel.buy = 0.005
        viewModel.sell = 0.004
        XCTAssertTrue(viewModel.calculateSpread() == 0.001)
        
        viewModel.buy = 0.004
        viewModel.sell = 0.005
        XCTAssertTrue(viewModel.calculateSpread() == -0.001)
        
        viewModel.buy = 0.00
        viewModel.sell = 0.00
        XCTAssertTrue(viewModel.calculateSpread() == 0.0)
    }
}
