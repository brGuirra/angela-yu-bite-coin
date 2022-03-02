//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoinData(_ coinManager: CoinManager, coinInfo: CoinModel) {
        DispatchQueue.main.async { [weak self] in
            self?.currencyLabel.text = coinInfo.formatedPriceAsString
            self?.bitcoinLabel.text = coinInfo.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

