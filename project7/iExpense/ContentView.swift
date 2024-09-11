// Created by brainfck on 7/29/24.

import SwiftData
import SwiftUI

struct ContentView: View {
  @Query var expenses: [ExpenseItem]

  @State private var showingAddExpense = false

  @State private var sortOder = [
    SortDescriptor(\ExpenseItem.amount),
    SortDescriptor(\ExpenseItem.name)
  ]
  
  @State private var filter = "ALL"

  var body: some View {
    NavigationStack {
      ExpensesView(filter: filter, sortOrder: sortOder)
        .navigationTitle("Expenses")
        .toolbar {
          Button("Add Item", systemImage: "plus") {
            showingAddExpense = true
          }
          
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOder) {
              Text("Sort by Name")
                .tag([
                  SortDescriptor(\ExpenseItem.name),
                  SortDescriptor(\ExpenseItem.amount),
                ])
              
              Text("Sort by Amount")
                .tag([
                  SortDescriptor(\ExpenseItem.amount),
                  SortDescriptor(\ExpenseItem.name),
                ])
            }
          }
          
          Menu("Filter", systemImage: "line.horizontal.3.decrease") {
            Picker("Filter", selection: $filter) {
              Text("ALL").tag("ALL")
              Text("Business").tag("Business")
              Text("Personal").tag("Personal")
            }
          }
        }
        .sheet(isPresented: $showingAddExpense) {
          AddView()
        }
    }
  }
}

#Preview {
  let previewContainer = try! ModelContainer(for: ExpenseItem.self)

  return ContentView()
    .modelContainer(previewContainer)
}
