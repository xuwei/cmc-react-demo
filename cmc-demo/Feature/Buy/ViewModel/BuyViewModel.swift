//
//  BuyViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 1/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class BuyViewModel {
    var sections = [CTableSectionViewModel]()
    
    init() {
        
    }
    
    func load() {
        let section = CTableSectionViewModel()
        let spacer1 = SpacerTableViewCellViewModel()
        section.rows.append(spacer1)
        let tradeHeader = TradeHeaderViewCellViewModel()
        section.rows.append(tradeHeader)
        let spacer2 = SpacerTableViewCellViewModel()
        section.rows.append(spacer2)
        let amountEntry = AmountEntryTableViewCellViewModel()
        section.rows.append(amountEntry)
        self.sections.append(section)
    }
}
