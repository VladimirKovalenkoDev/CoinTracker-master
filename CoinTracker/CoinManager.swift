//
//  CoinManager.swift
//  CoinTracker
//
//  Created by Владимир Коваленко on 20.04.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice (_ coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
     var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "11530448-984E-4636-9D0B-37D8073B56AA"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
   

    func getPrice (for currency: String){
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
      
        if let url = URL(string: urlString) {// it is optional cos it can be an error
        // create url session
          let session = URLSession(configuration: .default)
          // GIVE THE session a task
          let task = session.dataTask(with: url) { (data, response, error) in
                 if error != nil {
                  self.delegate?.didFailWithError(error: error!)
                       return
                   }
                      
          if let safeData = data {
            if let coinModel = self.parseJSON(safeData){
                
                self.delegate?.didUpdatePrice( self , coinModel: coinModel )

            }
             
          }
                                }
          // start the task
          task.resume()
          }
    }
        func parseJSON(_ data: Data) -> CoinModel? {
          let decoder = JSONDecoder()
          do {
              
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodeData.rate
            
            let coinModel = CoinModel(currencyLabelNumber: lastPrice)
            //print(lastPrice)
              return coinModel
          }catch{
             delegate?.didFailWithError(error: error  )
            print(error)
              return nil
              }
          }
    }
    
  


