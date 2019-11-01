//
//  CTableSectionViewModel.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

// represents one section of the table
// consist of a list of viewModels that conforms to CTableViewCellViewModelProtocol
class CTableSectionViewModel: NSObject {
    var title = ""
    var rows = [CTableViewCellViewModelProtocol]()
}
