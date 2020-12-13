//
//  ViewController.swift
//  BitCoin App
//
//  Created by Simon Wilson on 09/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var yenLabel: UILabel!
    
    @IBOutlet weak var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.setValue("Hello There", forKey: "hey")
        
        //UserDefaults.standard.string(forKey: "hey")
        
        if let usd =  UserDefaults.standard.string(forKey: "USD") {
            
            usdLabel.text = usd
            
        }
        
        if let eur =  UserDefaults.standard.string(forKey: "EUR") {
            
            eurLabel.text = eur
            
        }
        
        if let jpy =  UserDefaults.standard.string(forKey: "JPY") {
            
            yenLabel.text = jpy
            
        }
        
        getPrice()
        
    }
    
    func getPrice() {
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    
                    if data != nil {
                        
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double] {
                            
                            DispatchQueue.main.async {
                                
                                if let usdPrice = json["USD"] {
                                    
                                    self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                    
                                    UserDefaults.standard.setValue(self.getStringFor(price: usdPrice, currencyCode: "USD") + "~", forKey: "USD")
                                    
                                }
                                
                                if let eurPrice = json["EUR"] {
                                    
                                    self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                                    
                                    UserDefaults.standard.setValue(self.getStringFor(price: eurPrice, currencyCode: "EUR") + "~", forKey: "EUR")
                                    
                                }
                                
                                if let yenPrice = json["JPY"] {
                                    
                                    self.yenLabel.text = self.getStringFor(price: yenPrice, currencyCode: "JPY")
                                    
                                    UserDefaults.standard.setValue(self.getStringFor(price: yenPrice, currencyCode: "JPY") + "~", forKey: "JPY")
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                } else {
                    
                    print("we have an error")
                    
                }
                
                
                
            }.resume()
            
        }
        
        
    }
    
    func getStringFor(price: Double, currencyCode: String) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        formatter.currencyCode = currencyCode
        
        if let priceString = formatter.string(from: NSNumber(value: price)) {
            
            return priceString
            
        }
        
        return "Error"
        
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        
        getPrice()
        
    }
}

