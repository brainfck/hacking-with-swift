// Created by brainfck on 9/14/24.

import SwiftUI

struct ContentView: View {
  @State private var blurAmount = 0.0 {
    didSet {
      print("New value is \(blurAmount)")
    }
  }
  
  var body: some View {
    VStack {
      Text("Hello World")
        .blur(radius: blurAmount)
      
      Slider(value: $blurAmount, in: 0...20)
      
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
