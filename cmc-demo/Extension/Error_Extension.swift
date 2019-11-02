//
//  Error_Extension.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

// to extract more information from Alamofire error 
extension Error {
    func code()->Int? {
        if let error = self as? ErrorResponse {
            switch error {
            case .error(let code, _, _):
                return code
            }
        }
        return nil
    }
    
    func message()->String? {
        if let error = self as? ErrorResponse {
            switch error {
            case .error(_, _, let err):
                return err.localizedDescription
            }
        }
        return nil
    }
}
