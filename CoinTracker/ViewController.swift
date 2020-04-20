//
//  ViewController.swift
//  CoinTracker
//
//  Created by Владимир Коваленко on 19.04.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
var coinManger = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManger.delegate = self
        
         
    }
}
// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyPicked = coinManger.currencyArray[row]
        coinManger.getPrice(for: currencyPicked)
       print(coinManger.currencyArray[row])
        self.bitcoinLabel.text = self.coinManger.currencyArray[row]
    }


func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManger.currencyArray.count
}
}
    
// MARK: - CoinManagerDelegate
extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinModel.currencyString
            
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

