// Created by brainfck on 7/4/24.

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  
  @FocusState private var amountIsFocused: Bool
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let amountPerPerson = totalAmountForCheck / peopleCount
    
    return amountPerPerson
  }
  
  var totalAmountForCheck: Double {
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    
    return grandTotal
  }
  
  var body: some View {
    NavigationStack{
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
          .pickerStyle(.navigationLink)
        }
        
        Section("How much tip do you want to leave?") {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<101) {
              Text("\($0)%")
            }
          }
          .pickerStyle(.navigationLink)
        }
        
        Section("Total amount for the check") {
          Text(totalAmountForCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .foregroundColor(tipPercentage == 0 ? .red : .black)
        }
        
        Section("Amount per person") {
          Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if amountIsFocused {
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
