// Created by brainfck on 7/29/24.

import SwiftUI
import Observation

struct ContentView: View {
  @State private var expenses = Expenses()
  @State private var showingAddExpense = false
  
  var body: some View {
    NavigationStack {
      Section("Personal") {
        List {
          ForEach(expenses.items) { item in
            if(item.type == "Personal") {
              ExpenseView(name: item.name, type: item.type, amount: item.amount)
            }
          }
          .onDelete(perform: removeItems)
        }
        .navigationTitle("iExpense")
        .toolbar {
          Button("Add Expense", systemImage: "plus") {
            showingAddExpense = true
          }
        }
      }
      
      Section("Business") {
        List {
          ForEach(expenses.items) { item in
            if(item.type == "Business") {
              ExpenseView(name: item.name, type: item.type, amount: item.amount)
            }
          }
          .onDelete(perform: removeItems)
        }
      }
    }
    .sheet(isPresented: $showingAddExpense) {
      AddView(expenses: expenses)
    }
  }
  
  func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

struct ExpenseView: View {
  let name: String
  let type: String
  let amount: Double
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(name)
          .font(.headline)
        Text(type)
      }
      
      Spacer()
      Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .foregroundStyle(amount < 10 ? .green : amount < 100 ? .blue : .red)
    }
  }
}

#Preview {
  ContentView()
}
