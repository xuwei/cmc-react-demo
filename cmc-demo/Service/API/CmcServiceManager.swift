//
//  CmcServiceManager.swift
//  cmc-demo
//
//  Created by Xuwei Liang on 2/11/19.
//  Copyright © 2019 Xuwei Liang. All rights reserved.
//

import UIKit
import PromiseKit

enum CmcServiceTask: String {
    case blockchainTicker = "blockchainTicker"
}

class CmcServiceManager {
    static let shared = CmcServiceManager()
    let blockchainPriceTickerPoll = 15.0
    var timers = [String: Timer]()
    var blockchainPriceTicker: Timer = Timer()
    var blockchainPrices = [String: PriceInfo]()
    private init() {
        self.start()
    }
    
    fileprivate func getBitcoinPrices()->Promise<Price> {
        return Promise<Price>() { resolver in
            BitcoinPriceAPI.tickerGetWithRequestBuilder().execute { (response, err) in
                if let error = err {
                    resolver.reject(error)
                    return
                }
                
                if let price = response?.body {
                    resolver.fulfill(price)
                } else {
                    resolver.reject(CmcServiceError.unableToGetBlockchainPrices)
                }
            }
        }
    }
}

extension CmcServiceManager {
    
    func blockchainPrice(_ currency: String)-> PriceInfo {
        let priceInfo = self.blockchainPrices[currency] ?? PriceInfo(_15m: 0, last: 0, buy: 0, sell: 0, symbol: "$")
        return priceInfo
    }
    
    fileprivate func scheduleTask(_ task: CmcServiceTask, isRepeat: Bool, poll: Double) {
        switch task {
        case .blockchainTicker:
            let timer = Timer.scheduledTimer(timeInterval: blockchainPriceTickerPoll, target: self, selector: #selector(blockchainTicker), userInfo: nil, repeats: true)
            timers[task.rawValue] = timer
        }
    }
    
    func start() {
        // invalidate all first to avoid duplicates
        invalidateAll()
        
        self.scheduleTask(.blockchainTicker, isRepeat: true, poll: blockchainPriceTickerPoll)
    }
    
    func invalidateAll() {
        timers.forEach { (key, timer) in
            let timer = timers[key]
            timer?.invalidate()
        }
    }
    
    fileprivate func savePrices(_ price: Price) {
        let currencies = Currency.allSupported()
        let mirror = Mirror(reflecting: price)
        for child in mirror.children {
            if let varName = child.label, let currency = Currency(rawValue: varName),
                currencies.contains(currency), let priceInfo = child.value as? PriceInfo {
                self.blockchainPrices[currency.rawValue] = priceInfo
            }
        }
        
        AppData.shared.lastRefreshed = Date().timeStamp()
        
    }
    
    @objc func blockchainTicker() {
        LoggingUtil.shared.cPrint("blockchainTicker")
        CmcServiceManager.shared.getBitcoinPrices().done { price in
            self.savePrices(price)
            NotificationService.shared.notifyPrices(prices: self.blockchainPrices)
        }.catch { err in
            NotificationService.shared.notifyError(error: err)
        }
    }
}
