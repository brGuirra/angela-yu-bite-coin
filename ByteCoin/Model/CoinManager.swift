//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(_ coinManager: CoinManager, coinInfo: CoinModel)
    
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Coin-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Coin-Info'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find 'API_KEY' in 'Coin-Info'.")
            }
            
            return value
        }
    }
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    let currencyArray = ["BRL","CAD","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, request, error) in
                if error != nil {
                    return
                }
                
                if let data = data {
                    if let coinInfo = parseJSON(data) {
                        delegate?.didUpdateCoinData(self, coinInfo: coinInfo)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            
            let coinModel = CoinModel(price: rate, currency: currency)
            
            return coinModel
        } catch {
            print(error)
            
            return nil
        }
    }
}
