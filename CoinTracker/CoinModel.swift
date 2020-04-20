//
//  CoinModel.swift
//  CoinTracker
//
//  Created by Владимир Коваленко on 20.04.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation

struct CoinModel {
    let currencyLabelNumber: Double!
   // let bitcoinLabeltext: String
    
    var currencyString: String{
        return String(format: "%.1f", currencyLabelNumber)
    }
}
