//
//  Stock.swift
//  APIApp
//
//  Created by Christopher Walter on 4/10/20.
//  Copyright © 2020 DocsApps. All rights reserved.
//

import Foundation

class Stock: CustomStringConvertible
{
    var symbol: String
    var lastRefreshed: String // format "2020-04-09"
    var dailyStats: [StockDaily]
    
    public var description: String { // this is like the toString Method in java
        var dailyStat = ""
        for stat in dailyStats
        {
            if stat.date == lastRefreshed
            {
                dailyStat = stat.description
            }
        }
        return "Symbol: \(symbol)\nLastRefreshed: \(lastRefreshed)\n\(dailyStat)"
    }
    
    init(data: [String: Any])
    {
        /*
         Data will come in as JSON and look like this...
        ["Time Series (Daily)": {
             "2019-11-15" =     {
                 "1. open" = "263.6800";
                 "2. high" = "265.7800";
                 "3. low" = "263.0100";
                 "4. close" = "265.7600";
                 "5. volume" = 25093666;
             };
         ... a bunch more dates.. Those dates will become the daily Stats
         
         }, "Meta Data": {
             "1. Information" = "Daily Prices (open, high, low, close) and Volumes";
             "2. Symbol" = AAPL;
             "3. Last Refreshed" = "2020-04-09";
             "4. Output Size" = Compact;
             "5. Time Zone" = "US/Eastern";
         }]
         
         */
        let generalData = data["Meta Data"] as? [String: Any]
        self.symbol = generalData?["2. Symbol"] as? String ?? "error"
        self.lastRefreshed = generalData?["3. Last Refreshed"] as? String ?? "error"
        // load daily stats....
        self.dailyStats = [StockDaily]()
        guard let allStats = data["Time Series (Daily)"] as? [String: [String: Any]] else {
                print("not stock data")
                return
            }
        
        for day in allStats
        {
            let date = day.key
            let currentDayData = day.value
            let dayStats = StockDaily(data: currentDayData, date: date, symbol: self.symbol)
            self.dailyStats.append(dayStats)
        }
        
    }
}
