//
//  AmountEntryTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class AmountEntryTableViewCell: CTableViewCell, UITextFieldDelegate {
    
    @IBOutlet var unitTitleLabel: CLabel!
    @IBOutlet var amountTitleLabel: CLabel!
    @IBOutlet var unitTextField: CTextField!
    @IBOutlet var amountTextField: CTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupUI() {
        self.viewModel = AmountEntryTableViewCellViewModel()
        let vm = self.viewModel as! AmountEntryTableViewCellViewModel
        unitTitleLabel.textColor = AppConfig.shared.activeTheme.highlightColor
        amountTitleLabel.textColor = AppConfig.shared.activeTheme.highlightColor
        amountTitleLabel.text = "Amount (\(vm.symbol()))"
        unitTextField.placeholder = "e.g. 100"
        unitTextField.keyboardType = .numberPad
        unitTextField.text = "\(vm.units)"
        unitTextField.setTextFieldState(.normal)
        unitTextField.font = AppConfig.shared.activeTheme.mediumFont
        amountTextField.placeholder = "e.g. 100.00"
        amountTextField.keyboardType = .decimalPad
        amountTextField.text = "\(vm.amount)"
        amountTextField.font = AppConfig.shared.activeTheme.mediumFont
        amountTextField.setTextFieldState(.normal)
    }
}


