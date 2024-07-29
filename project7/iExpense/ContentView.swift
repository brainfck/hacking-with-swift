// Created by brainfck on 7/29/24.

import SwiftUI
import Observation

struct ContentView: View {
  @State private var showingSheet = false
  
  var body: some View {
    Button("Show Sheet") {
      showingSheet.toggle()
    }
    .sheet(isPresented: $showingSheet) {
      SecondView(name: "Zalupa Michele")
    }
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
