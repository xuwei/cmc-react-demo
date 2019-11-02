//
//  ConfirmTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import NotificationCenter

class ConfirmTableViewCell: CTableViewCell {

    @IBOutlet var cancelButton: CButton!
    @IBOutlet var confirmButton: CButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.viewModel = ConfirmTableViewCellViewModel()
        let vm = self.viewModel as! ConfirmTableViewCellViewModel
        cancelButton.setTitle(vm.cancelTitle, for: .normal)
        confirmButton.setTitle(vm.confirmTitle, for: .normal)
        cancelButton.setType(.normal)
        confirmButton.setType(.confirm)
        cancelButton.isEnabled = true
        confirmButton.isEnabled = false
        addObservables()
    }
    
    func addObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(enableConfirm(_:)), name: NSNotification.Name(NotificationUIEvents.enableConfirmView.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(disableConfirm(_:)), name: NSNotification.Name(NotificationUIEvents.disableConfirmView.rawValue), object: nil)
    }
    
    @IBAction func confirm() {
        LoggingUtil.shared.cPrint("confirm")
        NotificationService.shared.notify(NotificationUIEvents.confirm.rawValue, key: "", object: nil)
    }
    
    @IBAction func cancel() {
        LoggingUtil.shared.cPrint("cancel")
        NotificationService.shared.notify(NotificationUIEvents.cancel.rawValue, key: "", object: nil)
    }
    
    @objc func enableConfirm(_ notification: NSNotification) {
        self.confirmButton.isEnabled = true
    }
    
    @objc func disableConfirm(_ notification: NSNotification) {
        self.confirmButton.isEnabled = false
    }
    
}
