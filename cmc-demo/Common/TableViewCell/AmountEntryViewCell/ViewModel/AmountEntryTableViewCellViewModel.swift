//
//  AmountEntryTableViewCellViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class AmountEntryTableViewCellViewModel: CTableViewCellViewModelProtocol {
    var identifier: String = "AmountEntryTableViewCell"
    var currency: Currency = AppData.shared.currentCurrency
    var tradeType: TradeType = .buy
    var amount: Double = 0.0
    var units: Double = 0.0
    
    func price()->PriceInfo {
        let price = CmcServiceManager.shared.blockchainPrice(AppData.shared.currentCurrency.rawValue)
        return price
    }
    
    func calculateAmountByUnits(_ units: Double) {
        
        if units <= 0 {
            self.amount = 0.0
            self.units = 0.0
            return
        }
        let priceInfo = price()
        let currentPrice = (tradeType == .buy) ? priceInfo.buy ?? 0.0 : priceInfo.sell ?? 0.0
        self.amount = Double(units) * currentPrice
        self.units = units
    }
    
    func calculatedUnitsByAmount(_ amount: Double) {
        if amount <= 0.0 {
            self.amount = 0.0
            self.units = 0
            return
        }
        
        let priceInfo = price()
        let currentPrice = (tradeType == .buy) ? priceInfo.buy ?? 0.0 : priceInfo.sell ?? 0.0
        self.units = currentPrice / amount
        self.amount = amount
    }
    
    func symbol()->String {
        return price().symbol ?? ""
    }
}
