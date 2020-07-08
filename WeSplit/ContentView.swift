//
//  ContentView.swift
//  WeSplit
//
//  Created by Ермоленко Константин on 07.07.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount    = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage  = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount  = Double(checkAmount) ?? 0
        
        let tipValue     = orderAmount * tipSelection / 100
        let totalAmount  = orderAmount + tipValue

        return totalAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount     = Double(numberOfPeople) ?? 0
        let amountPerPerson = peopleCount > 0 ? totalAmount / peopleCount : 0
        
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
