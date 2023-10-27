//
//  ContentView.swift
//  currencyConversor
//
//  Created by Diego Borrallo Herrero on 22/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MoneyConverter.shared
    
    private let currencyCodes = ["USD", "EUR", "JPY", "GBP"]
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{ Text("Cantidad a convertir")
                        TextField("Introduce la cantidad ", text:
                                    $viewModel.amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .border(Color.gray)
                    }
                    Section{ Text("De moneda: ")
                        Picker("Desde Moneda", selection:
                                $viewModel.baseCurrency){
                            ForEach(currencyCodes, id: \.self){
                                currency in Text(currency)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section{ Text("A moneda: ")
                        Picker("A Moneda", selection: $viewModel.targetCurrency){
                            ForEach(currencyCodes, id: \.self){
                                currency in Text(currency)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section{
                        Button("Convertir"){
                            viewModel.fetchRate()
                            print(viewModel.amount)
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        .padding(.vertical)
                    }
                    Section{ Text("Cantidad convertida: ")
                        Text(viewModel.result)
                            .multilineTextAlignment(.center)
                    }
                }
            }.padding()
            .navigationTitle("USAL Exchange")
            .navigationBarTitleDisplayMode(.automatic)
            .multilineTextAlignment(.center)
        }
            /*NavigationView{
             VStack {
             Form{
             Section{ Text("Tipo de conversión")
             Picker("Seleccione una opcion", selection: $selectedOptionIndex) {
             ForEach(0..<options.count, id: \.self) { index in
             Text(options[index]).tag(index)
             }
             }
             .pickerStyle(SegmentedPickerStyle())
             .padding(.top, 25)
             }
             
             Section{ Text("Cantidad a convertir")
             TextField("Introduzca cantidad", text: $viewModel.amount)
             .padding(EdgeInsets(top: 25, leading: 70, bottom: 25, trailing: 25))
             }
             Section{
             Button("Convertir") {
             if selectedOptionIndex >= 0 && selectedOptionIndex < options.count {
             viewModel.currency = options[selectedOptionIndex]
             }
             viewModel.convertAmount()
             }
             .buttonStyle(.bordered)
             .tint(.blue)
             }
             Section{ Text("Cantidad convertida:")
             Text("\(viewModel.convertedAmount)").padding(.top, 25)
             Spacer()
             }
             }
             }
             .navigationTitle("USAL Exchange")
             .navigationBarTitleDisplayMode(.inline)
             }*/
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
