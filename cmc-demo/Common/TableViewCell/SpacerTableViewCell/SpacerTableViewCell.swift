//
//  SpacerTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class SpacerTableViewCell: CTableViewCell {

    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupUI() {
       self.selectionStyle = .none
       self.backgroundColor = AppConfig.shared.activeTheme.backgroundColor
       self.isUserInteractionEnabled = false
       if self.viewModel == nil {
            self.viewModel = SpacerTableViewCellViewModel()
       }
       let vm = self.viewModel as! SpacerTableViewCellViewModel
       self.cellHeight.constant = vm.height
    }
}
