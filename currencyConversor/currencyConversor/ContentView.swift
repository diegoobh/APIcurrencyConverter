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
        
        VStack(spacing: 20){
            TextField("Introduce la cantidad ", text:
                        $viewModel.amount)
            .keyboardType(.decimalPad)
            .padding()
            .border(Color.gray, width: 0.5)
            
            Picker("Desde Moneda", selection:
                    $viewModel.baseCurrency){
                ForEach(currencyCodes, id: \.self){
                    currency in Text(currency)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Picker("A Moneda", selection: $viewModel.targetCurrency){
                ForEach(currencyCodes, id: \.self){
                    currency in Text(currency)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Button("Convertir"){
                viewModel.fetchRate()
                print(viewModel.amount)
            }.padding(.vertical)
            
            Text(viewModel.result)
                .multilineTextAlignment(.center)
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
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
