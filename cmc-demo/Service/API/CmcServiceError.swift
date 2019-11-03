//
//  CmsServiceManager_Error.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

enum CmcServiceError: Error {
    case unableToGetBlockchainPrices
}

extension CmcServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToGetBlockchainPrices:
            return NSLocalizedString("Error getting blockchain prices", comment: "")
        }
    }
}
