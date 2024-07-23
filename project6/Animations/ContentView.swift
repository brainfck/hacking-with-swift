// Created by brainfck on 7/23/24.

import SwiftUI

struct ContentView: View {
  @State private var animationAmount = 0.0
  
  var body: some View {
    Button("Tap Me") {
      withAnimation {
        animationAmount += 360
      }
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(.circle)
    .rotation3DEffect(
      .degrees(animationAmount),
      axis: (x: 0.5, y: 0.5, z: 1)
    )
  }
}

#Preview {
  ContentView()
}
