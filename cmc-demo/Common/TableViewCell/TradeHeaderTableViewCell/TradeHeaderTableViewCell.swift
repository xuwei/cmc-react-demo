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
        
        if self.viewModel == nil {
            self.viewModel = TradeHeaderViewCellViewModel()
        }
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        let vm = self.viewModel as! TradeHeaderViewCellViewModel
        
        marketLabel.font = AppConfig.shared.activeTheme.headerFont
        marketTypeLabel.font = AppConfig.shared.activeTheme.mediumFont
        marketLabel.textColor = AppConfig.shared.activeTheme.textColor
        marketTypeLabel.textColor = AppConfig.shared.activeTheme.textColor
        
        sellTitleLabel.textColor = AppConfig.shared.activeTheme.sellColor
        buyTitleLabel.textColor = AppConfig.shared.activeTheme.buyColor

        let priceInfo = vm.price()
        applyPriceFont(&self.sellPriceLabel, price: priceInfo.sell ?? 0.0)
        applyPriceFont(&self.buyPriceLabel, price: priceInfo.buy ?? 0.0)
        
        ViewStylingUtil.shared.applyGradient(buyPriceContainer, bgColors: [AppConfig.shared.activeTheme.backgroundColor, AppConfig.shared.activeTheme.highlightColor.withAlphaComponent(AppConfig.shared.activeTheme.nonActiveAlpha)])
        
        // fake fluctuation for the lowest and highest value for now
        let lastPrice = vm.price().last ?? 0.0
        let lowPriceString = FormatterUtil.shared.currencyFormat(lastPrice*0.8)
        lowPriceLabel.text = "L: \(lowPriceString)"
        lowPriceLabel.textColor = AppConfig.shared.activeTheme.lightGrayColor
        let highPriceString = FormatterUtil.shared.currencyFormat(lastPrice*1.2)
        highPriceLabel.text = "H: \(highPriceString)"
        highPriceLabel.textColor = AppConfig.shared.activeTheme.lightGrayColor
        
        marketLabel.text = "\(vm.currency.rawValue)-BTC"
        marketTypeLabel.text = "\(vm.tradeType.rawValue)\nmarket"
        
        spreadLabel.text = "\(vm.calculateSpread())"
        spreadLabel.textColor = AppConfig.shared.activeTheme.textColor
        
    }
}

extension TradeHeaderTableViewCell {
    func applyPriceFont(_ label: inout CLabel, price: Double) {
        label.font = AppConfig.shared.activeTheme.extraLargeFont
        label.textColor = AppConfig.shared.activeTheme.lightGrayColor
        let priceString = FormatterUtil.shared.currencyFormat(price)
        let priceAttributedText = NSMutableAttributedString(string: priceString)
    priceAttributedText.applyCustomFontsOnDecimals(AppConfig.shared.activeTheme.lightGrayColor, font: AppConfig.shared.activeTheme.mediumFont)
        label.attributedText = priceAttributedText
    }
}
