//
//  ViewController.swift
//  ByteCoin
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon.coin. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
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

//MARK: - UIPickerViewDelegate

extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        print(currency)
        coinManager.getCoinPrice(for: currency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController : CoinManagerDelegate {
    
    func didUpdateRate(_ price: String, _ currency: String) {
        DispatchQueue.main.async {
            
            self.currencyLabel.text = currency
            self.bitcoinLabel.text = price
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
