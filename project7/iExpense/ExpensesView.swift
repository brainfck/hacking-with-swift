// Created by brainfck on 9/11/24.

import SwiftData
import SwiftUI

struct ExpensesView: View {
  @Environment(\.modelContext) var modelContext
  @Query var expenseItems: [ExpenseItem]

  init(filter: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
    _expenseItems = Query(filter: #Predicate<ExpenseItem> { item in
      if filter == "ALL" {
        return true
      } else {
        return item.type == filter
      }
    }, sort: sortOrder)
  }

  var body: some View {
    List {
      ForEach(expenseItems) { item in
        ExpenseView(expenseItem: item)
      }
      .onDelete(perform: removeItems)
    }
  }
  
  func removeItems(at offsets: IndexSet) {
    for offset in offsets {
      let expense = expenseItems[offset]
      
      modelContext.delete(expense)
    }
  }
}

#Preview {
  ExpensesView(filter: "ALL", sortOrder: [SortDescriptor(\ExpenseItem.amount)])
    .modelContainer(for: ExpenseItem.self)
}
