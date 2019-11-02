//
//  TradeHeaderTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class TradeHeaderTableViewCell: CTableViewCell {
    
    @IBOutlet var marketLabel: CLabel!
    @IBOutlet var marketTypeLabel: CLabel!
    @IBOutlet var sellPriceLabel: CLabel!
    @IBOutlet var buyPriceLabel: CLabel!
    @IBOutlet var lowPriceLabel: CLabel!
    @IBOutlet var highPriceLabel: CLabel!
    
    @IBOutlet var sellTitleLabel: CLabel!
    @IBOutlet var buyTitleLabel: CLabel!
    
    @IBOutlet var sellPriceContainer: UIView!
    @IBOutlet var buyPriceContainer: UIView!
    
    @IBOutlet var spreadLabel: CLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setupUI() {
        self.viewModel = TradeHeaderViewCellViewModel()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        let vm = self.viewModel as! TradeHeaderViewCellViewModel
        
        marketLabel.font = AppConfig.shared.activeTheme.headerFont
        marketTypeLabel.font = AppConfig.shared.activeTheme.mediumFont
        
        sellTitleLabel.textColor = AppConfig.shared.activeTheme.sellColor
        buyTitleLabel.textColor = AppConfig.shared.activeTheme.buyColor
        
        sellPriceLabel.text = FormatterUtil.shared.currencyFormat(vm.price.sell ?? 0.0)
        sellPriceLabel.font = AppConfig.shared.activeTheme.extraLargeFont
        sellPriceLabel.textColor = AppConfig.shared.activeTheme.profitColor
        
        buyPriceLabel.text = FormatterUtil.shared.currencyFormat(vm.price.buy ?? 0.0)
        buyPriceLabel.font = AppConfig.shared.activeTheme.extraLargeFont
        buyPriceLabel.textColor = AppConfig.shared.activeTheme.profitColor
        ViewStylingUtil.shared.applyGradient(buyPriceContainer, bgColors: [.black, AppConfig.shared.activeTheme.highlightColor])
        
        // fake fluctuation for the lowest and highest value for now
        let lastPrice = vm.price.last ?? 0.0
        let lowPriceString = FormatterUtil.shared.currencyFormat(lastPrice*0.8)
        lowPriceLabel.text = "L: \(lowPriceString)"
        lowPriceLabel.textColor = AppConfig.shared.activeTheme.lightGrayColor
        let highPriceString = FormatterUtil.shared.currencyFormat(lastPrice*1.2)
        highPriceLabel.text = "H: \(highPriceString)"
        highPriceLabel.textColor = AppConfig.shared.activeTheme.darkGrayColor
        
        marketLabel.text = vm.currency.rawValue
        marketTypeLabel.text = "\(vm.tradeType.rawValue)\nmarket"
        
        spreadLabel.text = "\(vm.calculateSpread())"
        
    }
    
}
