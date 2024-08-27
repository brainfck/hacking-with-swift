// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List(0..<1000) { i in
        NavigationLink("Select \(i)", value: i)
      }
      .navigationDestination(for: Int.self) { selection in
          Text("You selected \(selection)")
      }
    }
  }
}

#Preview {
  ContentView()
}
