//
//  ViewStylingUtil.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit

class ViewStylingUtil {
    static let shared = ViewStylingUtil()
    private init() { }
    
    func applyGradient(_ view: UIView, bgColors: [UIColor]) {
        guard bgColors.isEmpty == false, bgColors.count >= 2 else { return }
        if let gradLayer = view.layer.sublayers?[0], gradLayer is CAGradientLayer {
            gradLayer.removeFromSuperlayer()
        }
        // setup gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.masksToBounds = false
        gradientLayer.frame = view.layer.bounds
        gradientLayer.colors = bgColors.map({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.opacity = 0.8;
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
