//
//  ViewController.swift
//  CoinTracker
//
//  Created by Владимир Коваленко on 19.04.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
let coinManger = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        
         
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyPicked = coinManger.currencyArray[row]
        coinManger.getPrice(for: currencyPicked)
       print(coinManger.currencyArray[row])
    }


func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManger.currencyArray.count
}
    
    
}
extension ViewController : CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinModel.currencyString
        }
    }
}

