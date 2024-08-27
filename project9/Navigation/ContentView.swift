// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List(0..<1000) { i in
        // already created without even tapping, showing is enough for creating
        NavigationLink("Tap me") {
          DetailView(number: i)
        }
      }
    }
  }
}

struct DetailView: View {
  var number: Int
  
  var body: some View {
    Text("Detail View \(number)")
  }
  
  init(number: Int) {
    self.number = number
    print("Creating detailed view \(number)")
  }
}

#Preview {
  ContentView()
}
