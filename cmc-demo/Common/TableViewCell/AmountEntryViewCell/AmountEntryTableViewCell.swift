//
//  AmountEntryTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum AmountEntryTextFieldTag: Int {
    case unit = 1
    case amount = 2
}

class AmountEntryTableViewCell: CTableViewCell {
    
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
        if self.viewModel == nil {
            self.viewModel = AmountEntryTableViewCellViewModel()
        }
        self.selectionStyle = .none
        self.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
        let vm = self.viewModel as! AmountEntryTableViewCellViewModel
        unitTitleLabel.textColor = AppConfig.shared.activeTheme.highlightColor
        amountTitleLabel.textColor = AppConfig.shared.activeTheme.highlightColor
        amountTitleLabel.text = "Amount (\(vm.symbol()))"
        unitTextField.placeholder = "e.g. 100.00"
        unitTextField.keyboardType = .decimalPad
        unitTextField.text = String(format:"%.2f", vm.units)
        unitTextField.setTextFieldState(.normal)
        unitTextField.font = AppConfig.shared.activeTheme.mediumFont
        amountTextField.placeholder = "e.g. 100.00"
        amountTextField.keyboardType = .decimalPad
        amountTextField.text = String(format:"%.2f", vm.amount)
        amountTextField.font = AppConfig.shared.activeTheme.mediumFont
        amountTextField.setTextFieldState(.normal)
        
        amountTextField.tag = AmountEntryTextFieldTag.amount.rawValue
        unitTextField.tag = AmountEntryTextFieldTag.unit.rawValue
        
        if vm.amount > 0.0, vm.units > 0, amountTextField.text?.isEmpty == false,  unitTextField.text?.isEmpty == false {
            LoggingUtil.shared.cPrint("We can enable confirmView")
            NotificationService.shared.notify(NotificationUIEvents.enableConfirmView.rawValue, key: "", object: nil)
        } else {
            NotificationService.shared.notify(NotificationUIEvents.disableConfirmView.rawValue, key: "", object: nil)
        }
    }
}


