//
//  SpacerTableViewCellViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class SpacerTableViewCellViewModel: CTableViewCellViewModelProtocol {
    var identifier: String = "SpacerTableViewCell"
    var height: CGFloat = CGFloat(AppConfig.shared.activeTheme.mediumPadding)
}
