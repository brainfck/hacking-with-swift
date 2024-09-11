// Created by brainfck on 7/29/24.

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query() var expenses: [ExpenseItem]

  @State private var showingAddExpense = false

  var body: some View {
    NavigationStack {
      Section {
        List {
          ForEach(expenses) { item in
            ExpenseView(expenseItem: item)
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
    }
    .sheet(isPresented: $showingAddExpense) {
      AddView()
    }
  }

  func removeItems(at offsets: IndexSet) {
    for offset in offsets {
      let expense = expenses[offset]

      modelContext.delete(expense)
    }
  }
}

#Preview {
  let previewContainer = try! ModelContainer(for: ExpenseItem.self)

  return ContentView()
    .modelContainer(previewContainer)
}
