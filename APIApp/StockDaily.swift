//
//  StockDaily.swift
//  APIApp
//
//  Created by Christopher Walter on 4/10/20.
//  Copyright © 2020 DocsApps. All rights reserved.
//

import Foundation

class StockDaily: CustomStringConvertible
{
    
    
    
    // JSON data looks like this...
    /*
    "2019-11-15" =     {
        "1. open" = "263.6800";
        "2. high" = "265.7800";
        "3. low" = "263.0100";
        "4. close" = "265.7600";
        "5. volume" = 25093666;
    };
 */
    var symbol: String
    var date: String
    var open: String
    var high: String
    var low: String
    var close: String
    var volume: Int
    var description: String { // this is like the toString Method in java
//        return "Symbol: \(symbol)\nDate: \(date)\nOpen: \(open)\nHigh: \(high)\nLow: \(low)\nClose: \(close)\nVolume: \(volume)"
        return "Open: \(open)\nHigh: \(high)\nLow: \(low)\nClose: \(close)\nVolume: \(volume)"
    }
    
    init(data: [String: Any], date: String, symbol: String)
    {
        
        self.open = data["1. open"] as? String ?? "error"
        self.high = data["2. high"] as? String ?? "error"
        self.low = data["3. low"] as? String ?? "error"
        self.close = data["4. close"] as? String ?? "error"
        self.volume = data["1. volume"] as? Int ?? 0
        self.date = date
        self.symbol = symbol
    }
}
