// Created by brainfck on 7/29/24.

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: ExpenseItem.self)
  }
}
