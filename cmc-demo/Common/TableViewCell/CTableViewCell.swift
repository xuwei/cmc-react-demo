//
//  CTableViewCell.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

protocol CTableViewCellProtocol {
    func setupUI()
}

class CTableViewCell: UITableViewCell, CTableViewCellProtocol {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        // subclass needs to override
    }

    // view model for cell
    var viewModel: CTableViewCellViewModelProtocol?
}
