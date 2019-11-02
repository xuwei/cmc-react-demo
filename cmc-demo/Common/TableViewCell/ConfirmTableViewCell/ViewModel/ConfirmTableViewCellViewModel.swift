//
//  ConfirmTableViewCellViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 3/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum ConfirmButton: String {
    case cancel = "Cancel"
    case confirm = "Confirm"
}

class ConfirmTableViewCellViewModel: CTableViewCellViewModelProtocol {
    var identifier: String = "ConfirmTableViewCell"
    var cancelTitle: String = ConfirmButton.cancel.rawValue
    var confirmTitle: String = ConfirmButton.confirm.rawValue
}
