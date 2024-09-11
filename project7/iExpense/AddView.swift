// Created by brainfck on 7/30/24.

import SwiftUI

struct AddView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = 0.0
  
  let types = ["Business", "Personal"]
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        
        Picker("Type", selection: $type) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        
        TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          .keyboardType(.decimalPad)
      }
      .navigationTitle("Add new expense")
      .toolbar {
        Button("Save") {
          let item = ExpenseItem(name: name, type: type, amount: amount)
          modelContext.insert(item)
          dismiss()
        }
      }
    }
  }
}

#Preview {
  AddView()
}
