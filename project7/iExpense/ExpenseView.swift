// Created by brainfck on 9/11/24.

import SwiftData
import SwiftUI

struct ExpenseView: View {
  let expenseItem: ExpenseItem

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(expenseItem.name)
          .font(.headline)
        Text(expenseItem.type)
      }

      Spacer()
      Text(expenseItem.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        .foregroundStyle(expenseItem.amount < 10 ? .green : expenseItem.amount < 100 ? .blue : .red)
    }
    .padding()
  }
}

#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
    let example = ExpenseItem(name: "Test Expense", type: "Business", amount: 12.0)

    return ExpenseView(expenseItem: example)
      .modelContainer(container)
  } catch {
    return Text("Failed to create preview: \(error.localizedDescription)")
  }
}
