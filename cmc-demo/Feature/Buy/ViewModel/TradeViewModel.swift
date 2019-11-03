//
//  BuyViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 1/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class TradeViewModel {
    var sections = [CTableSectionViewModel]()
    var tradeHeaderView = TradeHeaderViewCellViewModel()
    var amountEntry = AmountEntryTableViewCellViewModel()
    let spacer = SpacerTableViewCellViewModel()
    init() {
        
    }
    
    func load() {
        let section = CTableSectionViewModel()
        section.rows.append(spacer)
        section.rows.append(tradeHeaderView)
        section.rows.append(spacer)
        section.rows.append(amountEntry)
        self.sections.append(section)
    }
}
