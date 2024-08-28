// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List(0..<100) { i in
        Text("Row \(i)")
      }
      .navigationTitle("Title goes here")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.blue, for: .navigationBar)
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbar(.hidden, for: .navigationBar)
    }
  }
}


#Preview {
  ContentView()
}
