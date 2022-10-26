//
//  ContentView.swift
//  WeSplit
//
//  Created by Arthur Sh on 24.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    
    var originalAmountWithTip: Double {
        let tip = Double(tipPercentage)
        let tipPercentaged = checkAmount / 100 * tip
        let total = tipPercentaged + checkAmount
        
        return total
        
    }

    
    var totalPerPerson: Double {
        let TipPercent = Double(tipPercentage)
        let people = Double(numberOfPeople + 2)
        
        let dividedPercentage = checkAmount / 100 * TipPercent
        let GrandTotal = checkAmount + dividedPercentage
        let totalperson = GrandTotal / people
        
        return totalperson
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
               
                
                Section{
                    Picker("Tip percantage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Amount per person")
                }
                
                Section{
                    Text(originalAmountWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Total with tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done"){
                        isFocused = false
                    }
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
