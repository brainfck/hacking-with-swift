// Created by brainfck on 9/14/24.

import SwiftUI

struct ContentView: View {
  @State private var blurAmount = 0.0

  var body: some View {
    VStack {
      Text("Hello World")
        .blur(radius: blurAmount)

      Slider(value: $blurAmount, in: 0...20)
        .onChange(of: blurAmount) { _, newValue in
          print("New Value is \(newValue)")
        }

      Button("Random Blur") {
        blurAmount = Double.random(in: 0...20)
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
