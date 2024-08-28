// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  @State private var pathStore = PathStore()
  
  var body: some View {
    NavigationStack(path: $pathStore.path) {
      DetailedView(number: 0)
        .navigationDestination(for: Int.self) { i in
          DetailedView(number: i)
        }
    }
  }
}

struct DetailedView: View {
  var number: Int
  
  var body: some View {
    NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
      .navigationTitle("Number: \(number)")
  }
}

#Preview {
  ContentView()
}
