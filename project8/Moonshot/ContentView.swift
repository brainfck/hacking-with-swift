// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(.example)
        .resizable()
        .scaledToFit()
        .containerRelativeFrame(.horizontal) { size, axis in
          size * 0.8
        }
    }
  }
}

#Preview {
  ContentView()
}
