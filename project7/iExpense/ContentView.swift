// Created by brainfck on 7/29/24.

import SwiftUI
import Observation

struct ContentView: View {
  @State private var user = User(firstName: "Taylor", lastName: "Swift")
  
  var body: some View {
    Button("Save User") {
      let encoder = JSONEncoder()
      
      if let data = try? encoder.encode(user) {
        UserDefaults.standard.set(data, forKey: "UserData")
      }
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

struct User: Codable {
  let firstName: String
  let lastName: String
}

#Preview {
  ContentView()
}
