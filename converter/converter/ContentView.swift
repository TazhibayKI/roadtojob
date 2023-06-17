//
//  ContentView.swift
//  converter
//
//  Created by Куаныш Тажибай on 08.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var itemSelected = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    private let currencies = ["Volt", "Watt", "Ampere"]
    func convert  (_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedCurrensy = currencies[itemSelected]
        let to = currencies[itemSelected2]
       
        let WattRates = ["Ampere": 1.07 , "Watt": 1.0, "Volt": 477.99]
        let AmpereRates = ["Ampere": 1.0 , "Volt": 0.93, "Watt": 445.99]
        let VoltRates = ["Ampere": 0.0022 , "Watt": 0.0021, "Volt": 1.0]
        
        switch (selectedCurrensy){
        case "Watt" :
            conversion = amount * (WattRates[to] ?? 0.0)
        case "Ampere" :
            conversion = amount * (AmpereRates[to] ?? 0.0)
        case "Volt" :
            conversion = amount * (VoltRates[to] ?? 0.0)
        default:
            print("Error")
        }
   
        return String(format: "%.2f", conversion)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert a energy")) {
                    TextField("Enter an amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker(selection: $itemSelected, label: Text("From")){
                        ForEach(0..<currencies.count) {index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                    Picker(selection: $itemSelected2, label: Text("to")){
                        ForEach(0..<currencies.count) {index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                }
                Section(header: Text("Convertion")){
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
