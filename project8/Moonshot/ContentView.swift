// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  let layout = [
    GridItem(.adaptive(minimum: 80, maximum: 120)),
  ]
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: layout) {
        ForEach(0..<1000) {
          Text("Item \($0)")
        }
      }
    }
  }
}


#Preview {
  ContentView()
}
