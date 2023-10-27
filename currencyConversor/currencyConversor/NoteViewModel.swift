//
//  NoteViewModel.swift
//  currencyConversor
//
//  Created by Diego Borrallo Herrero on 22/10/23.
//

import Foundation
import SwiftUI

struct ExchangeRatesResponse : Codable{
    let conversion_rates : [String : Double]
    let base_code : String
    let time_last_update_utc : String
}

class MoneyConverter: ObservableObject {
    
    @Published var amount : String = ""
    @Published var baseCurrency : String = "USD"
    @Published var targetCurrency : String = "EUR"
    @Published var rate : Double = 0.0
    @Published var result : String = ""
    
    static let shared = MoneyConverter()
    
    let apiKey = "8727f438956b63f65a3c409c"
    
    func fetchRate(){
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(baseCurrency)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data{
                let decoder = JSONDecoder()
                
                do{
                    let response = try decoder.decode(ExchangeRatesResponse.self, from:data)
                    DispatchQueue.main.async{
                        self.rate = response.conversion_rates[self.targetCurrency] ?? 0.0
                        self.convert()
                    }
                }catch{
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func convert(){
        guard let amountValue = Double(amount) else{
            return
        }
        
        let convertedAmount = amountValue * rate
        result = "\(amountValue) \(baseCurrency) = \(convertedAmount) \(targetCurrency)"
    }
}

