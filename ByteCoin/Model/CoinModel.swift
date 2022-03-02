//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Bruno Guirra on 01/03/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let price: Double
    
    let currency: String
    
    var formatedPriceAsString: String {
        let price = NSNumber(value: self.price)
        
        let numberFormater = NumberFormatter()
        
        numberFormater.maximumFractionDigits = 2
        numberFormater.numberStyle = .decimal
        
        let formattedPrice = numberFormater.string(from: price)
        
        return formattedPrice ?? ""
    }
}
