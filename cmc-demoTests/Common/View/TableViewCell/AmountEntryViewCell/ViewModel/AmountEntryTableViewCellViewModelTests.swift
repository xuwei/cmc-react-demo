//
//  AmountEntryViewCellViewModelTests.swift
//  cmc-demoTests
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import XCTest
@testable import cmc_demo


// creating a mock object to override the price fetching code for our testing purpose
class AmountEntryTableViewCellViewModelMock: AmountEntryTableViewCellViewModel {
    override func price()->PriceInfo {
        return PriceInfo(_15m: 1000.00, last: 1000.00, buy: 1000.00, sell: 1000.00, symbol: "$")
    }
}

class AmountEntryTableViewCellViewModelTests: XCTestCase {

    let viewModel = AmountEntryTableViewCellViewModelMock()

    func testCalculateAmountByUnits() {
        viewModel.calculateAmountByUnits(20.0)
        
        // units x price should be amount
        XCTAssertTrue(viewModel.amount == 20000.00)
        
        viewModel.calculateAmountByUnits(10.0)
        XCTAssertTrue(viewModel.amount == 10000.00)
        
        // decimal amount should work
        viewModel.calculateAmountByUnits(0.5)
        XCTAssertTrue(viewModel.amount == 500.0)
        
        viewModel.calculateAmountByUnits(0.0)
        XCTAssertTrue(viewModel.amount == 0.0)
    }
    

    func testCalculatedUnitsByAmount() {
        viewModel.calculatedUnitsByAmount(20.0)
        // price / amounts = units
        // 1000 / 20 = 50
        XCTAssertTrue(viewModel.units == 50.0)
        
        viewModel.calculatedUnitsByAmount(10.0)
        XCTAssertTrue(viewModel.units == 100.0)
        
        viewModel.calculatedUnitsByAmount(0.5)
        XCTAssertTrue(viewModel.units == 2000.0)
        
        viewModel.calculatedUnitsByAmount(0.0)
        XCTAssertTrue(viewModel.amount == 0.0)
    }

    func testSymbol() {
        XCTAssertTrue(viewModel.symbol() == "$")
    }

}
