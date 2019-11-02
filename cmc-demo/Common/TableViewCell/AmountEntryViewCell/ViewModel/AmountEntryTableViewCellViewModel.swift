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
    var amount: Double = 0.0
    var units: Int = 0
    
    func calculateAmountByUnits(_ units: Int) {
        let price = CmcServiceManager.shared.blockchainPrice(AppData.shared.currentCurrency.rawValue)
        self.amount = Double(units) * (price.buy ?? 0.0)
        self.units = units
    }
    
    func calculatedUnitsByAmount(_ amount: Double) {
        guard amount >= 0.0 else { return }
        let price = CmcServiceManager.shared.blockchainPrice(AppData.shared.currentCurrency.rawValue)
        self.units = Int((price.buy ?? 0.0) / amount)
        self.amount = amount
    }
    
    func symbol()->String {
        let price = CmcServiceManager.shared.blockchainPrice(AppData.shared.currentCurrency.rawValue)
        return price.symbol ?? ""
    }
}
