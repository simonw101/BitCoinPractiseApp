//
//  ViewController.swift
//  BitCoin App
//
//  Created by Simon Wilson on 09/12/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    
                    print("its working")
                    
                } else {
                    
                    print("we have an error")
                    
                }
                
                
                
            }.resume()
            
        }
        
        
    }


}

