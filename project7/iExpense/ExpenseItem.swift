// Created by brainfck on 7/30/24.

import Foundation

struct ExpenseItem {
  let name: String
  let type: String
  let amount: Double
}


@Observable
class Expenses {
  var items = [ExpenseItem]()
}
