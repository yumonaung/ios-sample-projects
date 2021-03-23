//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Yu Mon Aung on 2021/03/23.
//  Copyright © 2021 example.yu.mon.coin. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "EBAC267C-7079-4328-A2F9-47FDC4A30F63"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate : CoinManagerDelegate?
    func getCoinPrice(for currency: String)  {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if  let url = URL(string: urlString){
            
            //Create URL Session
            
            let session = URLSession(configuration: .default)

            // Give a session task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        delegate?.didUpdateRate(priceString, currency)
                    }
                }
            }
           
            // Start the task
            task.resume()
        
        }
    }
    
   
    
    func parseJSON(_ data : Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: data)
            let lastPrice = decodedData.rate
            
            return lastPrice
        } catch  {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

protocol CoinManagerDelegate {
    func didUpdateRate (_ price: String,_ currency :String)
    func didFailWithError(_ error : Error)
}
