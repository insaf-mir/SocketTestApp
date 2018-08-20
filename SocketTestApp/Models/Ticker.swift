//
//  Ticker.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 20.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import Foundation

struct Ticker {
    let channelId: Int
    let bid: Double
    let bidSize: Double
    let ask: Double
    let askSize: Double
    let dailyChange: Double
    let dailyChangePercent: Double
    let lastPrice: Double
    let volume: Double
    let high: Double
    let low: Double
    let date: Date
    
    static func create(from data: String) -> Ticker? {
        let substrings = data.replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .split(separator: ",")
        if substrings.count != 11 {
            return nil
        }
        guard
            let channelId = Int(substrings[ArrayIndex.channelId.rawValue]),
            let bid = Double(substrings[ArrayIndex.bid.rawValue]),
            let bidSize = Double(substrings[ArrayIndex.bidSize.rawValue]),
            let ask = Double(substrings[ArrayIndex.ask.rawValue]),
            let askSize = Double(substrings[ArrayIndex.askSize.rawValue]),
            let dailyChange = Double(substrings[ArrayIndex.dailyChange.rawValue]),
            let dailyChangePercent = Double(substrings[ArrayIndex.dailyChangePercent.rawValue]),
            let lastPrice = Double(substrings[ArrayIndex.lastPrice.rawValue]),
            let volume = Double(substrings[ArrayIndex.volume.rawValue]),
            let high = Double(substrings[ArrayIndex.high.rawValue]),
            let low = Double(substrings[ArrayIndex.low.rawValue])
        else {
            return nil
        }
        return Ticker(
            channelId: channelId,
            bid: bid,
            bidSize: bidSize,
            ask: ask,
            askSize: askSize,
            dailyChange: dailyChange,
            dailyChangePercent: dailyChangePercent,
            lastPrice: lastPrice,
            volume: volume,
            high: high,
            low: low,
            date: Date()
        )
    }
    
    enum ArrayIndex: Int {
        case channelId
        case bid
        case bidSize
        case ask
        case askSize
        case dailyChange
        case dailyChangePercent
        case lastPrice
        case volume
        case high
        case low
    }
    
}
