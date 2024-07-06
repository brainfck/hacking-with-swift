// Created by brainfck on 7/6/24.

import SwiftUI

struct ContentView: View {
  private let units = ["C", "F", "K"]
  @State private var unitFromSelected = "C"
  @State private var unitToSelected = "F"
  @State private var tempValue = 0.0;
  
  @FocusState private var valueIsFocused: Bool
  
  private var convertedValue: Double {
    var celsiusValue = 0.0
    var resultValue = 0.0
    
    switch unitFromSelected {
    case "C":
      celsiusValue = tempValue
    case "F":
      celsiusValue = (tempValue - 32) * 5 / 9
    case "K":
      celsiusValue = tempValue - 273.15
    default:
      celsiusValue = tempValue
    }
    
    switch unitToSelected {
    case "C":
      resultValue = celsiusValue
    case "F":
      resultValue = celsiusValue * 9/5 + 32
    case "K":
      resultValue = celsiusValue + 273.15
    default:
      resultValue = celsiusValue
    }
    
    return resultValue
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          HStack {
            TextField("From", value: $tempValue, format: .number)
              .keyboardType(.decimalPad)
              .focused($valueIsFocused)
            
            Divider()
            
            Text(convertedValue, format: .number)
              .frame(maxWidth: .infinity)
          }
        }
        
        Section {
          HStack {
            VStack{
              Text("From")
                .bold()
              
              Picker("", selection: $unitFromSelected) {
                ForEach(units, id:\.self) {
                  Text($0)
                }
              }
              .pickerStyle(.segmented)
            }
            
            VStack {
              Text("To")
                .bold()
              Picker("", selection: $unitToSelected) {
                ForEach(units, id:\.self) {
                  Text($0)
                }
              }
              .pickerStyle(.segmented)
            }
            
          }
        }
      }
      .navigationTitle("TempConverter")
      .toolbar {
        if valueIsFocused {
          Button("Done") {
            valueIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
