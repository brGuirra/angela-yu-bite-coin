//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Bruno Guirra on 01/03/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    
    var formatedRateAsString: String {
        let rate = NSNumber(value: self.rate)
        
        let numberFormater = NumberFormatter()
        
        numberFormater.maximumFractionDigits = 2
        numberFormater.numberStyle = .decimal
        
        let formattedRate = numberFormater.string(from: rate)
        
        return formattedRate ?? ""
    }
}
