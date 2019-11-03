//
//  TradeHeaderViewCellViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum TradeType: String {
    case buy = "BUY"
    case sell = "SELL"
}

class TradeHeaderViewCellViewModel: CTableViewCellViewModelProtocol {
    var identifier: String = "TradeHeaderTableViewCell"
    var currency: Currency = AppData.shared.currentCurrency
    var buying: String = "BTC" // hardcode BTC for now 
    var tradeType: TradeType = .buy
    
    
    func price()->PriceInfo {
        return CmcServiceManager.shared.blockchainPrice(AppData.shared.currentCurrency.rawValue)
    }
    
    func calculateSpread()->Double {
        guard let buy = price().buy, let sell = price().sell else { return 0.0 }
        return buy - sell
    }
}
