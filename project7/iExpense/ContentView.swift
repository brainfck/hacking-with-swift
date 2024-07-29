// Created by brainfck on 7/29/24.

import SwiftUI
import Observation

struct ContentView: View {
  @State private var numbers = [Int]()
  @State private var currentNumber = 1
  
  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(numbers, id: \.self) {
            Text("Row \($0)")
          }
          .onDelete(perform: removeRows)
        }
        
        Button("Add Number") {
          numbers.append(currentNumber)
          currentNumber += 1
        }
      }
      .toolbar {
        EditButton()
      }
    }
    
    
  }
  
  func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
  }
}

struct SecondView: View {
  let name: String
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text("Hello, \(name).")
    
    Button("Dismiss") {
      dismiss()
    }
  }
}

// class instead of struct because we want to share data between different views
@Observable
class User {
  var firstName = "Bilbo"
  var lastName = "Baggins"
}

#Preview {
  ContentView()
}
