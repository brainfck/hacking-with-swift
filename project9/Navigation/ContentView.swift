// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  @State private var path = [Int]()
  
  var body: some View {
    NavigationStack(path: $path) {
      DetailedView(number: 0, path: $path)
        .navigationDestination(for: Int.self) { i in
          DetailedView(number: i, path: $path)
        }
    }
  }
}

struct DetailedView: View {
  var number: Int
  @Binding var path: [Int]
  
  var body: some View {
    NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
      .navigationTitle("Number: \(number)")
      .toolbar {
        Button("Home") {
          path.removeAll()
        }
      }
  }
}

#Preview {
  ContentView()
}
